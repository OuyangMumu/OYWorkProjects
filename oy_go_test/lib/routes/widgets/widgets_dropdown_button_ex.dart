/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({Key key}) : super(key: key);
  @override
  _DropdownButtonExampleState createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  static const menuItems = <String>[
    "One",
    "Two",
    'Three',
    'Four',
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems =
      menuItems.map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
      .map((String value) => PopupMenuItem(
            child: Text(value),
            value: value,
          ))
      .toList();
  String _btn1SelectedVa1 = 'One';
  String _btn2SelectedVa1;
  String _btn3SelectedVa1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('DropDownButton with default:'),
          trailing: DropdownButton<String>(
            value: _btn1SelectedVa1,
            onChanged: (String newValue) {
              setState(() {
                this._btn1SelectedVa1 = newValue;
              });
            },
            items: this._dropDownMenuItems,
          ),
        ),
        ListTile(
          title: Text('DropDownButton with hint:'),
          trailing: DropdownButton(
            value: _btn2SelectedVa1,
            hint: Text('Choose'),
            onChanged: ((String newValue) {
              setState(() {
                _btn2SelectedVa1 = newValue;
              });
            }),
            items: _dropDownMenuItems,
          ),
        ),
        ListTile(
          title: const Text('Popup menu button:'),
          trailing: new PopupMenuButton<String>(
            onSelected: (String newValue) {
              _btn3SelectedVa1 = newValue;
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(_btn3SelectedVa1),
                ),
              );
            },
            itemBuilder: (BuildContext context) => _popUpMenuItems,
          ),
        ),
      ],
    );
  }
}
