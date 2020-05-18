/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/4
 */

import 'package:flutter/material.dart';

class AnimatedWidgetExample extends StatefulWidget {
  const AnimatedWidgetExample({Key key}) : super(key: key);
  @override
  _AnimatedWidgetExampleState createState() => _AnimatedWidgetExampleState();
}

class _AnimatedWidgetExampleState extends State<AnimatedWidgetExample>
    with SingleTickerProviderStateMixin {
  Animation<double> _sizeAnimation;
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    this._sizeAnimation =
        Tween<double>(begin: 50, end: 100).animate(this._controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this._controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _AnimatedLogo(
          animation: this._sizeAnimation,
        ),
        RaisedButton(
            child: Text('Forward animation'),
            onPressed: () {
              _controller.forward();
            }),
        RaisedButton(
            child: Text('Reverse animation'),
            onPressed: () {
              _controller.reverse();
            }),
      ],
    );
  }
}

class _AnimatedLogo extends AnimatedWidget {
  _AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;
    return Center(
      child: Container(
        margin: EdgeInsets.all(8),
        child: FlutterLogo(),
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}
