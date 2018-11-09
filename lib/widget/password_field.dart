import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  PasswordField(
      {this.key,
      this.hintText,
      this.labelText,
      this.helperText,
      this.decorationIcon,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted})
      : super(key: key);

  final Key key;
  final String hintText;
  final String labelText;
  final String helperText;
  final Icon decorationIcon;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  State<StatefulWidget> createState() {
    return _PasswordFieldState();
  }
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.hintText,
        icon: widget.decorationIcon,
        suffixIcon: GestureDetector(
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
