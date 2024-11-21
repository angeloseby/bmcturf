// Function to validate the phone number (basic pattern for a 10-digit number)
String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }
  final phoneRegex = RegExp(r'^[0-9]{10}$');
  if (!phoneRegex.hasMatch(value)) {
    return 'Enter a valid 10-digit phone number';
  }
  return null;
}

// Function to validate the password (minimum 6 characters)
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }
  return null;
}

bool showHidePassword(bool currentState) {
  return currentState == false ? true : false;
}
