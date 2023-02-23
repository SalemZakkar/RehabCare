getMyAuthError(String errorCode, String errorMessage) {
  if (errorCode == "weak-password") {
    return "The password provided is too weak.";
  } else if (errorCode == "email-already-in-use") {
    return "The account already exists for that email.";
  } else if (errorCode == 'user-not-found') {
    return 'No user found for that email.';
  } else if (errorCode == 'wrong-password') {
    return 'Wrong password provided for that user';
  } else if (errorCode == 'invalid-email') {
    return 'The email address is badly formatted.';
  } else {
    return errorMessage.toString();
  }
}
