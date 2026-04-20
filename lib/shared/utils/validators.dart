bool isValidEmail(String value) {
  return RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$').hasMatch(value);
}
