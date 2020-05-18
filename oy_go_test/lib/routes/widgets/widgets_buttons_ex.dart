/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ButtonsExample extends StatefulWidget {
  const ButtonsExample({Key key}) : super(key: key);
  @override
  _ButtonsExampleState createState() => _ButtonsExampleState();
}

class _ButtonsExampleState extends State<ButtonsExample> {
  @override
  Widget build(BuildContext context) {
    final _showToast = () {
      Fluttertoast.showToast(
          msg: "Button tapped", toastLength: Toast.LENGTH_SHORT);
    };
    final _showSnack = () {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Button tapped Snack"),
        backgroundColor: Colors.lightBlue,
        duration: Duration(milliseconds: 500),
      ));
    };

    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        Column(
          children: <Widget>[
            Text('Raised buttons add dimension to mostly flat layouts. They '
                'emphasize functions on busy or wide spaces.'),
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.phone),
                      SizedBox(
                        width: 10,
                      ),
                      Text("FlatButton"),
                    ],
                  ),
                  onPressed: _showSnack,
                ),
                RaisedButton(
                  child: Text("dis-RaisedButton"),
                  onPressed: null,
                )
              ],
            ),
            Divider(),
            Column(
              children: <Widget>[
                Text('A flat button displays an ink splash on press '
                    'but does not lift. Use flat buttons on toolbars, in dialogs '
                    'and inline with padding'),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.phone),
                          Text("FlatButton"),
                        ],
                      ),
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: _showToast,
                    ),
                    FlatButton(
                      child: Text("dis-FlatButton"),
                      onPressed: null,
                    )
                  ],
                )
              ],
            ),
            Divider(),
            Column(
              children: <Widget>[
                Text(
                    'Outline buttons become opaque and elevate when pressed. They '
                    'are often paired with raised buttons to indicate an '
                    'alternative, secondary action.'),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    OutlineButton(
                      onPressed: _showToast,
                      child: Text("OutlineButton"),
                    ),
                    OutlineButton(
                      onPressed: null,
                      child: Text("dis-OutlineButton"),
                    ),
                  ],
                )
              ],
            ),
            Divider(),
            Column(
              children: <Widget>[
                Text(
                    'Tooltips are short identifying messages that briefly appear '
                    'in response to a long press. Tooltip messages are also used '
                    'by services that make Flutter apps accessible, like screen '
                    'readers.'),
                Center(
                  child: IconButton(
                    icon: Icon(Icons.call),
                    iconSize: 32,
                    tooltip: 'Place a phone call',
                    onPressed: _showSnack,
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
