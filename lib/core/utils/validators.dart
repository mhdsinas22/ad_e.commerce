class Validators {
  // -------------------------
  // Required field
  // -------------------------
  static String? requiredField(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? "This field"} is required';
    }
    return null;
  }

  // -------------------------
  // Minimum length
  // -------------------------
  static String? minLength(String? value, int length) {
    if (value == null || value.trim().length < length) {
      return 'Minimum $length characters required';
    }
    return null;
  }

  // -------------------------
  // Email validation
  // -------------------------
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  // -------------------------
  // Mobile number validation
  // (India focused)
  // -------------------------
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required';
    }

    final phoneRegex = RegExp(r'^[6-9]\d{9}$');

    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid 10 digit mobile number';
    }

    return null;
  }

  // -------------------------
  // Optional field + min length
  // -------------------------
  static String? optionalMinLength(String? value, int length) {
    if (value == null || value.isEmpty) return null;

    if (value.length < length) {
      return 'Minimum $length characters required';
    }

    return null;
  }
}
