class Validators {
  bool isEmailValid(String email) {
    // Regular expression pattern for email validation
    RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[\w-]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
