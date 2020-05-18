import 'dart:math';

/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/4
 */

import 'package:flutter/material.dart';

class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({Key key}) : super(key: key);
  @override
  _AnimatedContainerExampleState createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  final _rng = Random();
  double _height = 100;
  double _width = 100;
  double _borderRaidus = 8;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(seconds: 1),
          margin: EdgeInsets.all(8),
          child: FlutterLogo(),
          width: this._width,
          height: this._height,
          decoration: BoxDecoration(
              color: this._color,
              borderRadius: BorderRadius.circular(this._borderRaidus)),
          curve: Curves.fastOutSlowIn,
        ),
        RaisedButton.icon(
            onPressed: () {
              setState(() {
                // Generate a random width and height.
                _width = _rng.nextInt(100).toDouble() + 50;
                _height = _rng.nextInt(100).toDouble() + 50;
                _borderRaidus = _rng.nextInt(50).toDouble();
                // Generate a random color.
                _color = Color.fromRGBO(
                    _rng.nextInt(256), _rng.nextInt(256), _rng.nextInt(256), 1);
              });
            },
            icon: Icon(Icons.update),
            label: Text('Change random Property'))
      ],
    );
  }
}
