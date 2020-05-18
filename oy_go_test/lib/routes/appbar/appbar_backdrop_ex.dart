import 'package:backdrop/backdrop.dart';
/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';

class BackdropExample extends StatelessWidget {
  const BackdropExample({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: Text("Backdrop demo"),
      iconPosition: BackdropIconPosition.action,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ],
      headerHeight: 200,
      frontLayer: Center(
        child: Text(
            '(front layer) \n Click top-right button to show back layer.\n\n'
            "There's no flutter official backdrop widget, this demo uses the "
            "'backdrop' package."),
      ),
      backLayer: Center(
        child: Text('Back layer'),
      ),
    );
  }
}
