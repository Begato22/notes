import 'package:flutter/material.dart';

class DefaultTextFormField extends StatefulWidget {
  final String label;
  final bool isMultiLine;
  final bool isPassword;
  final TextInputType keyboardType;
  final Function(String value) validator;
  final Function(String value) onSave;
  const DefaultTextFormField({
    super.key,
    required this.label,
    required this.validator,
    required this.onSave,
    this.keyboardType = TextInputType.text,
    this.isMultiLine = false,
    this.isPassword = false,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  bool _isHiddenPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.label,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isHiddenPassword = !_isHiddenPassword;
                  });
                },
                icon: Icon(_isHiddenPassword
                    ? Icons.visibility
                    : Icons.visibility_off),
              )
            : null,
      ),
      maxLines: widget.isMultiLine ? 5 : 1,
      obscureText: widget.isPassword ? _isHiddenPassword : false,
      validator: (value) => widget.validator(value!),
      onSaved: (newValue) {
        widget.onSave(newValue!);
      },
    );
  }
}
