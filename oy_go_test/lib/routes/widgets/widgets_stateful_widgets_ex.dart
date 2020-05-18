/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';

class StatefulWidgetsExample extends StatefulWidget {
  const StatefulWidgetsExample({Key key}) : super(key: key);
  @override
  _StatefulWidgetsExampleState createState() => _StatefulWidgetsExampleState();
}

class _StatefulWidgetsExampleState extends State<StatefulWidgetsExample> {
  bool _switchVal = true;
  bool _checkBoxVal = false;
  double sliderVal = 0.5;
  double sliderVal2 = 50;
  int _radioVal = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text('switch'),
        Center(
          child: Switch(
              value: this._switchVal,
              onChanged: (value) {
                setState(() {
                  this._switchVal = value;
                });
              }),
        ),
        Text('Disable Switch'),
        Center(
          child: Switch(value: false, onChanged: null),
        ),
        Divider(),
        Text('CheckBox'),
        Checkbox(
            value: this._checkBoxVal,
            onChanged: (val) {
              setState(() {
                this._checkBoxVal = val;
              });
            }),
        Text('Disabled Checkbox'),
        Checkbox(value: false, onChanged: null),
        Divider(),
        Text('Slider with Divisions and Label'),
        Slider(
            value: this.sliderVal,
            onChanged: (val) {
              setState(() {
                sliderVal = val;
              });
            }),
        Divider(),
        Text('LinearProgersssIndicator'),
        LinearProgressIndicator(),
        Divider(),
        Text('CircularProgressIndicator'),
        Center(
          child: CircularProgressIndicator(),
        ),
        Divider(),
        Text('Radio'),
        Row(
            children: [0, 1, 2, 3, 4]
                .map((int i) => Radio(
                      value: i,
                      groupValue: this._radioVal,
                      onChanged: (value) {
                        setState(() {
                          this._radioVal = value;
                        });
                      },
                    ))
                .toList()),
        Divider()
      ],
    );
  }
}
