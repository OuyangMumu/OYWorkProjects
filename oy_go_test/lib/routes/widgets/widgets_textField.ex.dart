/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/2
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({Key key}) : super(key: key);

  @override
  _TextfieldExampleState createState() => _TextfieldExampleState();
}

class _TextfieldExampleState extends State<TextFieldExample> {
  bool _numerInfputIsValid = true;

  Widget _buildNumberTextField() {
    return TextField(
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.headline,
      decoration: InputDecoration(
          icon: Icon(Icons.attach_money),
          labelText: 'Enter an integer:',
          errorText: _numerInfputIsValid ? null : "please enter a number",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      onSubmitted: (value) {
        Fluttertoast.showToast(msg: "you entered: ${int.parse(value)}");
      },
      onChanged: (value) {
        final v = int.tryParse(value);
        debugPrint('parsed value = $v');
        if (v == null) {
          setState(() {
            _numerInfputIsValid = false;
          });
        } else {
          setState(() {
            _numerInfputIsValid = true;
          });
        }
      },
    );
  }

  final _controller = TextEditingController();

  Widget _buildMutilineTextField() {
    return TextField(
      controller: _controller,
      maxLines: 5,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          counterText: '${_controller.text.split(" ")}',
          labelText: "Enter mutliline text",
          hintText: "type somethings...",
          border: OutlineInputBorder()),
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  bool _showPassword = false;

  Widget _buildPasswordTextField() {
    return TextField(
      obscureText: !_showPassword,
      decoration: InputDecoration(
        labelText: "password",
        prefix: Icon(Icons.security),
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye,
              color: _showPassword ? Colors.blue : Colors.grey),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
    );
  }

  Widget _buildBorderlessTextField() {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration.collapsed(hintText: 'borderless input'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(9.0),
      children: <Widget>[
        ListTile(
          title: Text("1. Number input field"),
        ),
        _buildNumberTextField(),
        ListTile(
          title: Text("2. mutilline input field"),
        ),
        _buildMutilineTextField(),
        ListTile(
          title: Text("3. password input field"),
        ),
        _buildPasswordTextField(),
        ListTile(
          title: Text("4. Borderless input field"),
        ),
        _buildBorderlessTextField(),
      ],
    );
  }
}
