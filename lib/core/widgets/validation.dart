abstract class Validation {
  static bool validateEmail(String email) {
    final RegExp emailRedExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRedExp.hasMatch(email);
  }

  static bool validatePassword(String password) {
    final RegExp passwordRedExt =
        RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return passwordRedExt.hasMatch(password);
  }
}