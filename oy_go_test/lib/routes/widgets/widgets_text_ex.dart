/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/2
 */

import 'package:flutter/material.dart';

class TextExample extends StatelessWidget {
  const TextExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Simple text demo",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
        ),
        Text(
          'system style',
          style: Theme.of(context)
              .textTheme
              .body1
              .copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ],
    );
  }
}
