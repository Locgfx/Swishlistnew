import 'package:flutter/material.dart';
import 'package:swishlist/constants/color.dart';

class AppTFDecoration {
  final String hint;
  AppTFDecoration({required this.hint});

  InputDecoration decoration() {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyle().textColor70707014w400,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      filled: true,
      fillColor: ColorSelect.colorEDEDF1,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorSelect.colorE0E0E0, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorSelect.colorF7E641, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorSelect.kD53535, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorSelect.kD53535, width: 2),
      ),
    );
  }
}
