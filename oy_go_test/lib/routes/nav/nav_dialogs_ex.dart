/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/4
 */

import 'package:flutter/material.dart';

class DialogsExample extends StatelessWidget {
  const DialogsExample({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(32),
      children: <Widget>[
        RaisedButton(
            color: Colors.redAccent,
            child: Text('Alert Dialog'),
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  content: Text('AlertDialog content'),
                  title: const Text('AlertDialog title'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () => Navigator.pop(context, "Cancle"),
                        child: Text('Cancle')),
                    FlatButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: Text('OK')),
                  ],
                ),
              ).then((returnVal) {
                if (returnVal != null) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('You clicked: $returnVal'),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {},
                    ),
                  ));
                }
              });
            }),
        RaisedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Text('SimpleDialog title'),
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('user@example.com'),
                        onTap: () {
                          Navigator.pop(context, 'user@example.com');
                        },
                      ),
                    ],
                  );
                }).then((returnVal) {
              if (returnVal != null) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('You clicked: $returnVal'),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {},
                  ),
                ));
              }
            });
          },
          color: Colors.yellow,
          child: Text('Simple dialog'),
        ),
        RaisedButton(
          color: Colors.green,
          child: Text('Time Picker Dialog'),
          onPressed: () {
            DateTime now = DateTime.now();
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
            ).then((TimeOfDay value) {
              if (value != null) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${value.format(context)}'),
                    action: SnackBarAction(label: 'OK', onPressed: () {}),
                  ),
                );
              }
            });
          },
        ),
        RaisedButton(
          color: Colors.blue,
          child: Text('Date Picker Dialog'),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2018),
              lastDate: DateTime(2025),
            ).then((DateTime value) {
              if (value != null) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Selected datetime: $value')),
                );
              }
            });
          },
        ),
        RaisedButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                backgroundColor: Theme.of(context).primaryColor,
                builder: (BuildContext) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.black12))),
                    child: ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: <Widget>[
                        ListTile(
                          title: Text('this is a bottom sheet'),
                          dense: true,
                        ),
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text(
                                'Ok',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Text('Bottom Sheet'),
          color: Colors.orange,
        )
      ],
    );
  }
}
