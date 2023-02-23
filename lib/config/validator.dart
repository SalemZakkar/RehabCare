class Validator {
  static bool checkName(String x) {
    bool containsLetters = false;
    containsLetters = RegExp(r"^(?=.*?[أ-ي])").hasMatch(x) ||
        RegExp(r"^(?=.*?[A-z])").hasMatch(x);
    return containsLetters;
  }

  static bool checkNumber(String x) {
    try {
      double.parse(x.toString());
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool checkEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool checkPassword(String password) {
    int space = 0;
    for (int i = 0; i < password.length; i++) {
      if (password[i] == " ") {
        space++;
      }
    }
    return space == 0 &&
        RegExp(r"^(?=.*?[(-}])").hasMatch(password) &&
        password.length >= 5;
  }
}
