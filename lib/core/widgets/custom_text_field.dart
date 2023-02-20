import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.prefix,
    required this.validator,
    required this.label,
    this.obscureText = false,
    this.suffix,
    this.suffixFunc,
    this.onChanged,
  });
  final TextEditingController controller;
  final TextInputType keyboardType;
  final IconData prefix;
  final IconData? suffix;
  final Function? suffixFunc;
  final Function validator;
  final Function? onChanged;
  final String label;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: GestureDetector(
          child: Icon(suffix),
          onTap: () => suffixFunc!(),
        ),
        hintText: label,
        border: const UnderlineInputBorder(),
      ),
      obscureText: obscureText,
      validator: (val) => validator(val),
      onChanged: (value) {
        onChanged != null ? onChanged!(value) : null;
      },
    );
  }
}
