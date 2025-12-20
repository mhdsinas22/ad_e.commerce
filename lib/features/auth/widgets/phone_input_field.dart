import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AppPhoneInputField extends StatelessWidget {
  final void Function(String phoneNumber) onChanged;
  final String hintText;
  final String initialCountryCode;
  final String keyvalue;
  final bool enabled;
  final bool readOnly;
  final String initialValue;
  const AppPhoneInputField({
    super.key,
    required this.onChanged,
    this.hintText = 'Your Number',
    this.initialCountryCode = 'IN',
    this.keyvalue = "",
    this.enabled = true,
    this.readOnly = false,
    this.initialValue = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: IntlPhoneField(
        initialValue: initialValue,
        readOnly: readOnly,
        enabled: enabled,
        key: Key(keyvalue),
        disableLengthCheck: true,
        initialCountryCode: initialCountryCode,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.phone),
        ),
        dropdownTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
        showDropdownIcon: false,
        onChanged: (phone) {
          onChanged(phone.number);
        },
      ),
    );
  }
}
