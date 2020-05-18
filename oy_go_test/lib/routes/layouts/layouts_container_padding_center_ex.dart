/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';

class ContainerExample extends StatefulWidget {
  const ContainerExample({Key key}) : super(key: key);
  @override
  _ContainerExampleState createState() => _ContainerExampleState();
}

class _ContainerExampleState extends State<ContainerExample> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.blue,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black),
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.fromLTRB(10, 20, 30, 40),
            child: Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
//              transform: Matrix4.rotationX(1),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10), right: Radius.circular(30))),
                alignment: Alignment.center,
                child: Text('Hello'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
