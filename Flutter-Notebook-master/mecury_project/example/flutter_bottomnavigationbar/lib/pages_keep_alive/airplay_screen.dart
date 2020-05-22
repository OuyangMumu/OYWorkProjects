import 'package:flutter/material.dart';

class AirPlayScreen extends StatefulWidget {
  @override
  _AirPlayScreenState createState() => _AirPlayScreenState();
}

class _AirPlayScreenState extends State<AirPlayScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Homepage"),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return Container(
                height: 40,
                child: Text("$index"),
              );
            },
          ),
        ));
  }
}
