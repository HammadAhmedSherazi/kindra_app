import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/extension.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.autofocus = false,
    this.padding,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool autofocus;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: context.robotoFlexRegular(fontSize: 17, color: Colors.black),
          ),
          8.ph,
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          autofocus: autofocus,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          
          maxLines: obscureText ? 1 : maxLines,
          minLines: minLines,
          maxLength: maxLength,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          onTap: onTap,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            contentPadding: padding ?? EdgeInsets.symmetric( vertical: 20),
            hintText: hint,
            
            hintStyle: TextStyle(
color: Colors.black.withValues(alpha: 0.3),
fontSize: 14.87,
fontFamily: 'Roboto Flex',
fontWeight: FontWeight.w300,
height: 1.08,
),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: const Color(0xFF393939)),
              borderRadius: BorderRadius.circular(29),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: theme.colorScheme.error),
              borderRadius: BorderRadius.circular(29),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: theme.colorScheme.error),
              borderRadius: BorderRadius.circular(29),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: const Color(0xFF393939)),
              borderRadius: BorderRadius.circular(29),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: const Color(0xFF393939)),
              borderRadius: BorderRadius.circular(29),
            ),
            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixIconConstraints,
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixIconConstraints,
            errorText: hasError ? errorText : null,
            errorStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
              fontSize: 11,
            ),
          ),
        ),
        if (helperText != null && helperText!.isNotEmpty && !hasError) ...[
          6.ph,
          Text(
            helperText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.primaryTextColor.withValues(alpha: 0.7),
            ),
          ),
        ],
      ],
    );
  }
}
