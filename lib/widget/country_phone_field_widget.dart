import 'package:flutter/material.dart';

import '../utils/extension.dart';
import 'custom_text_field_widget.dart';

/// Model for country code (code, dial code, flag) used in phone fields.
class CountryCode {
  const CountryCode({
    required this.code,
    required this.dialCode,
    required this.flag,
  });
  final String code;
  final String dialCode;
  final String flag;
}

/// Default list of country codes for the country phone field.
const List<CountryCode> defaultCountryCodes = [
  CountryCode(code: 'PK', dialCode: '+92', flag: '🇵🇰'),
  CountryCode(code: 'US', dialCode: '+1', flag: '🇺🇸'),
  CountryCode(code: 'GB', dialCode: '+44', flag: '🇬🇧'),
  CountryCode(code: 'IN', dialCode: '+91', flag: '🇮🇳'),
  CountryCode(code: 'ID', dialCode: '+62', flag: '🇮🇩'),
  CountryCode(code: 'AE', dialCode: '+971', flag: '🇦🇪'),
  CountryCode(code: 'SA', dialCode: '+966', flag: '🇸🇦'),
  CountryCode(code: 'CA', dialCode: '+1', flag: '🇨🇦'),
  CountryCode(code: 'AU', dialCode: '+61', flag: '🇦🇺'),
];

/// A reusable text field with country code dropdown prefix for mobile/phone input.
class CountryPhoneFieldWidget extends StatefulWidget {
  const CountryPhoneFieldWidget({
    super.key,
    required this.controller,
    this.initialCountry,
    this.countryCodes = defaultCountryCodes,
    this.label = 'Mobile Number',
    this.hint = 'Enter number',
    this.textInputAction = TextInputAction.done,
    this.validator,
    this.onCountryChanged,
  });

  final TextEditingController controller;
  final CountryCode? initialCountry;
  final List<CountryCode> countryCodes;
  final String label;
  final String hint;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final void Function(CountryCode)? onCountryChanged;

  @override
  State<CountryPhoneFieldWidget> createState() =>
      _CountryPhoneFieldWidgetState();
}

class _CountryPhoneFieldWidgetState extends State<CountryPhoneFieldWidget> {
  late CountryCode _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry ??
        (widget.countryCodes.isNotEmpty
            ? widget.countryCodes.first
            : defaultCountryCodes.first);
  }

  @override
  void didUpdateWidget(CountryPhoneFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCountry != null &&
        widget.initialCountry != oldWidget.initialCountry) {
      _selectedCountry = widget.initialCountry!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldWidget(
      controller: widget.controller,
      label: widget.label,
      hint: widget.hint,
      keyboardType: TextInputType.phone,
      textInputAction: widget.textInputAction,
      prefixIconConstraints: const BoxConstraints(minWidth: 100, minHeight: 26),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 20, right: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<CountryCode>(
            value: _selectedCountry,
            isExpanded: false,
            icon: const Icon(Icons.keyboard_arrow_down, size: 24),
            items: widget.countryCodes
                .map(
                  (c) => DropdownMenuItem<CountryCode>(
                    value: c,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(c.flag, style: const TextStyle(fontSize: 18)),
                        6.pw,
                        Text(
                          c.dialCode,
                          style: TextStyle(
                            fontSize: 14.87,
                            fontFamily: 'Roboto Flex',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) {
                setState(() => _selectedCountry = v);
                widget.onCountryChanged?.call(v);
              }
            },
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
