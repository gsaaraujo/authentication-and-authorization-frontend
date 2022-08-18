import 'package:authentication_and_authorization_frontend/src/app/styles/app_texts.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  const InputText({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.icon,
    this.textInputType,
    this.maxLength = 255,
    this.isPassword = false,
  }) : super(key: key);

  final String label;
  final int maxLength;
  final bool isPassword;
  final Widget? icon;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final Function(String)? validator;

  @override
  State<InputText> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<InputText> {
  bool hasText = false;
  bool isPasswordHiden = false;

  @override
  void initState() {
    isPasswordHiden = widget.isPassword;

    widget.controller.addListener(() {
      setState(() {
        widget.controller.text.isEmpty ? hasText = false : hasText = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      obscureText: isPasswordHiden,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      style: AppTexts.textInput,
      decoration: InputDecoration(
        counterText: '',
        labelText: widget.label,
        prefixIcon: widget.icon,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.isPassword
                  ? isPasswordHiden = !isPasswordHiden
                  : widget.controller.clear();
            });
          },
          icon: Icon(
            widget.isPassword
                ? isPasswordHiden
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined
                : hasText
                    ? Icons.highlight_remove_rounded
                    : null,
          ),
        ),
      ),
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        if (widget.validator != null) return widget.validator!(value);
        return null;
      },
    );
  }
}
