import 'package:flutter/material.dart';

class LoginSignUpField extends StatefulWidget {
  final bool obscureText;
  final Color backgroundColor;
  final String hintText;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final void Function(String) onFieldSubmitted;
  final TextStyle style;
  final String initValue;
  const LoginSignUpField({
    Key? key,
    this.obscureText = false,
    this.backgroundColor = Colors.white,
    required this.hintText,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onSaved,
    required this.style,
    required this.onFieldSubmitted,
    this.initValue = ''
  }) : super(key: key);

  @override
  _LoginSignUpFieldState createState() => _LoginSignUpFieldState();
}

class _LoginSignUpFieldState extends State<LoginSignUpField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        //prefixIcon: Icon(widget.icon, size: Theme.of(context).iconTheme.size),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: widget.hintText,
        fillColor: widget.backgroundColor,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        errorStyle: const TextStyle(
          fontSize: 11.0
        ),
      ),
      obscureText: widget.obscureText,
      textAlign: TextAlign.center,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      onSaved: widget.onSaved,
      focusNode: widget.focusNode,
      style: widget.style,
      onFieldSubmitted: widget.onFieldSubmitted,
      initialValue: widget.initValue,
    );
  }
}
