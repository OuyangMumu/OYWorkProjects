/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';

class WrapExample extends StatefulWidget {
  const WrapExample({Key key}) : super(key: key);
  @override
  _WrapExampleState createState() => _WrapExampleState();
}

class _WrapExampleState extends State<WrapExample> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      direction: Axis.horizontal,
      children: [
        'Cauchy',
        'Fourrier',
        'Lagrange',
        'Lebesgue',
        'Levy',
        'Poisson',
        'Pointcare',
      ]
          .map((String name) => Chip(
                label: Text(name),
                avatar: CircleAvatar(
                  child: Text(name.substring(0, 1)),
                ),
              ))
          .toList(),
    );
  }
}
