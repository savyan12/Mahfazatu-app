import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/app_constants.dart';

class SupabaseService {
  static SupabaseService? _instance;
  late final SupabaseClient client;

  SupabaseService._() {
    client = Supabase.instance.client;
  }

  static SupabaseService get instance {
    _instance ??= SupabaseService._();
    return _instance!;
  }

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      publishableKey: AppConstants.supabaseAnonKey,
    );
  }

  static SupabaseService get I => instance;

  GoTrueClient get auth => client.auth;
}
