-- =============================================
-- Mahfazati — Supabase Schema
-- Run this in Supabase SQL Editor
-- =============================================

-- 1. PROFILES
create table if not exists public.profiles (
  id            uuid primary key references auth.users(id) on delete cascade,
  email         text unique not null,
  phone         text unique,
  first_name    text not null default '',
  last_name     text not null default '',
  gender        text check (gender in ('male','female')),
  avatar_url    text,
  balance       numeric(12,2) not null default 0.00,
  reward_points integer not null default 0,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);

-- 2. CARDS
create table if not exists public.cards (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid not null references public.profiles(id) on delete cascade,
  card_number     text not null,
  cardholder_name text not null,
  expiry_date     text not null,
  cvv             text,
  card_type       text check (card_type in ('visa','mastercard','amex')),
  is_active       boolean not null default true,
  created_at      timestamptz not null default now()
);

-- 3. TRANSACTIONS
create table if not exists public.transactions (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null references public.profiles(id) on delete cascade,
  type          text not null check (type in ('topup','transfer','payment','redeem')),
  amount        numeric(12,2) not null,
  currency      text not null default 'LYD',
  status        text not null default 'completed' check (status in ('pending','completed','failed')),
  description   text,
  reference_id  text,
  counterparty  text,
  created_at    timestamptz not null default now()
);

-- 4. PREPAID CARDS (للشحن)
create table if not exists public.prepaid_cards (
  id          uuid primary key default gen_random_uuid(),
  code        text unique not null,
  amount      numeric(12,2) not null,
  currency    text not null default 'LYD',
  is_used     boolean not null default false,
  used_by     uuid references public.profiles(id),
  used_at     timestamptz,
  created_at  timestamptz not null default now(),
  expires_at  timestamptz not null
);

-- 5. MERCHANTS
create table if not exists public.merchants (
  id           uuid primary key default gen_random_uuid(),
  name         text not null,
  category     text not null check (category in ('cafe','shopping','restaurant','services')),
  description  text,
  latitude     double precision not null,
  longitude    double precision not null,
  rating       numeric(2,1) not null default 0,
  icon_name    text not null default 'store',
  accent_color text not null default '#2EBD8A',
  is_active    boolean not null default true,
  created_at   timestamptz not null default now()
);

-- 6. OFFERS
create table if not exists public.offers (
  id               uuid primary key default gen_random_uuid(),
  merchant_id      uuid not null references public.merchants(id) on delete cascade,
  title            text not null,
  description      text,
  badge            text,
  discount_text    text not null,
  points_required  integer not null,
  is_active        boolean not null default true,
  created_at       timestamptz not null default now()
);

-- 7. REWARD REDEMPTIONS
create table if not exists public.reward_redemptions (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null references public.profiles(id) on delete cascade,
  offer_id      uuid not null references public.offers(id),
  points_spent  integer not null,
  status        text not null default 'pending' check (status in ('pending','redeemed','cancelled')),
  created_at    timestamptz not null default now()
);

-- ========== INDEXES ==========
create index if not exists idx_transactions_user_id on public.transactions(user_id);
create index if not exists idx_transactions_created_at on public.transactions(created_at desc);
create index if not exists idx_cards_user_id on public.cards(user_id);
create index if not exists idx_offers_merchant_id on public.offers(merchant_id);
create index if not exists idx_merchants_category on public.merchants(category);

-- ========== TRIGGER: AUTO-CREATE PROFILE ON SIGNUP ==========
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, email, phone, first_name, last_name)
  values (
    new.id,
    new.email,
    new.phone,
    coalesce(new.raw_user_meta_data ->> 'first_name', ''),
    coalesce(new.raw_user_meta_data ->> 'last_name', '')
  );
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ========== RLS ==========
alter table if exists public.profiles enable row level security;
alter table if exists public.cards enable row level security;
alter table if exists public.transactions enable row level security;
alter table if exists public.prepaid_cards enable row level security;
alter table if exists public.merchants enable row level security;
alter table if exists public.offers enable row level security;
alter table if exists public.reward_redemptions enable row level security;

-- Profiles
drop policy if exists "Users can read own profile" on public.profiles;
create policy "Users can read own profile"
  on public.profiles for select using (auth.uid() = id);

drop policy if exists "Users can update own profile" on public.profiles;
create policy "Users can update own profile"
  on public.profiles for update using (auth.uid() = id);

-- Cards
drop policy if exists "Users can read own cards" on public.cards;
create policy "Users can read own cards"
  on public.cards for select using (auth.uid() = user_id);

drop policy if exists "Users can insert own cards" on public.cards;
create policy "Users can insert own cards"
  on public.cards for insert with check (auth.uid() = user_id);

-- Transactions
drop policy if exists "Users can read own transactions" on public.transactions;
create policy "Users can read own transactions"
  on public.transactions for select using (auth.uid() = user_id);

drop policy if exists "Users can insert own transactions" on public.transactions;
create policy "Users can insert own transactions"
  on public.transactions for insert with check (auth.uid() = user_id);

-- Merchants (public read)
drop policy if exists "Merchants are publicly readable" on public.merchants;
create policy "Merchants are publicly readable"
  on public.merchants for select using (true);

-- Offers (public read)
drop policy if exists "Offers are publicly readable" on public.offers;
create policy "Offers are publicly readable"
  on public.offers for select using (true);

-- Reward redemptions
drop policy if exists "Users can read own redemptions" on public.reward_redemptions;
create policy "Users can read own redemptions"
  on public.reward_redemptions for select using (auth.uid() = user_id);

drop policy if exists "Users can insert own redemptions" on public.reward_redemptions;
create policy "Users can insert own redemptions"
  on public.reward_redemptions for insert with check (auth.uid() = user_id);
