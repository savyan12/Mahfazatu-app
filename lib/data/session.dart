import 'user.dart';

class Session {
  Session._();

  static User? currentUser;
  static List<User> users = [];

  static bool login(String email, String password) {
    final user = users.where(
      (u) => u.email == email && u.password == password,
    );
    if (user.isNotEmpty) {
      currentUser = user.first;
      return true;
    }
    return false;
  }

  static void register(User user) {
    users.add(user);
    currentUser = user;
  }
}
