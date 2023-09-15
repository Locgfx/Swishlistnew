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



class AppTFWithIconDecoration {
  final String hint;
  final Widget icon;
  AppTFWithIconDecoration( {required this.hint,required this.icon});

  InputDecoration decoration() {
    return InputDecoration(
      suffixIconConstraints: BoxConstraints(
          maxHeight: 40,maxWidth: 60),
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: icon
      ),
      hintText: hint,
      hintStyle: AppTextStyle().textColor70707014w400,
      contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
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