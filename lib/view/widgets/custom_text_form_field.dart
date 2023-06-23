import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constance.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required this.label,
      this.hint,
      this.focusNode,
      this.controller,
      this.onTap,
      this.radius = 10.0,
      required this.icon,
      this.prefix,
      this.obscure = false,
      this.enabled,
      this.value,
      this.keyboardType,
      this.onChanged,
      this.validator, this.readOnly = false})
      : super(key: key);

  final FocusNode? focusNode;
  final String label;
  final TextEditingController? controller;
  final String? hint;
  final double radius;
  final Widget? icon;
  final Widget? prefix;
  final bool obscure;
  final bool readOnly;
  final bool? enabled;
  final String? value;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      initialValue: value,
      enabled: enabled,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscure,
      keyboardType: keyboardType,
      onTap: onTap,
      readOnly: readOnly,
      decoration: InputDecoration(
          labelText: label,
          floatingLabelStyle: GoogleFonts.lateef(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.grey),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(radius)),
          hintText: hint,
          prefix: prefix,
          prefixStyle: TextStyle(),
          labelStyle: style3,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
          suffixIcon: icon),
    );
  }
}
