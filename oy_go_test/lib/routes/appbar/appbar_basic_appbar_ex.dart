/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';

class BasicAppbarExample extends StatefulWidget {
  const BasicAppbarExample({Key key}) : super(key: key);

  @override
  _BasicAppbarExampleState createState() => _BasicAppbarExampleState();
}

class _BasicAppbarExampleState extends State<BasicAppbarExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: Icon(Icons.tag_faces),
        title: Text('Sample title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.directions_bike),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.directions_boat),
            onPressed: () {},
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text('Boat')),
                PopupMenuItem(child: Text('Train'))
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}
