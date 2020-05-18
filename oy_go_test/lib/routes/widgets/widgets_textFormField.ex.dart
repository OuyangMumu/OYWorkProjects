/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/2
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldExample extends StatefulWidget {
  const TextFormFieldExample({Key key}) : super(key: key);
  @override
  _TextFormFieldExampleState createState() => _TextFormFieldExampleState();
}

class _TextFormFieldExampleState extends State<TextFormFieldExample> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  String name;
  String phoneNumber;
  String email;
  String password;

  String validateName(String value) {
    if (value.isEmpty) {
      return "Name is required";
      final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
      if (!nameExp.hasMatch(value)) {
        return "Please enter only alphabetical characters";
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 24.0,
          ),
          TextFormField(
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: Icon(Icons.person),
                hintText: "what do people call you",
                labelText: "Name **",
                alignLabelWithHint: true),
            onSaved: (value) {
              this.name = value;
            },
            validator: validateName,
          ),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              icon: Icon(Icons.phone),
              hintText: "Where can we reach you？",
              labelText: "phone number **",
              prefixText: "+86",
            ),
            keyboardType: TextInputType.phone,
            onSaved: (value) {
              this.phoneNumber = value;
            },
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly,
            ],
          ),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              icon: Icon(Icons.email),
              hintText: "you email address",
              labelText: "e-mail",
            ),
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) {
              this.email = value;
            },
          ),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(),
              hintText: "tell us about youSelf",
              helperText: "keep it short this is just a demo",
//              labelText: "lift story",
              alignLabelWithHint: true,
            ),
            textAlignVertical: TextAlignVertical.top,
            maxLines: 3,
          ),
          SizedBox(
            height: 24,
          ),
          PasswordField(
            fieldKey: _passwordFieldKey,
            helperText: "No more than 8 characters",
            labelText: "Password**",
            onFieldSubmitted: (value) {
              setState(() {
                this.password = value;
              });
            },
          ),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            enabled: this.password != null && this.password.isNotEmpty,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              filled: false,
              labelText: "Re-type password",
            ),
            maxLength: 8,
            obscureText: true,
          )
        ],
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> vilidator;
  final ValueChanged<String> onFieldSubmitted;
  const PasswordField(
      {Key key,
      this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.vilidator,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.vilidator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
