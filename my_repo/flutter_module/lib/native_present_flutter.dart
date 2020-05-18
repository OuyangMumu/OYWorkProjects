import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter/cupertino.dart';

class NativePresentFlutter extends StatefulWidget {
  NativePresentFlutter({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _NativePresentFlutterState createState() => _NativePresentFlutterState();
}

class _NativePresentFlutterState extends State<NativePresentFlutter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return NativePresentFlutter(
                    title: "flutter push again",
                  );
                }));
              },
              child: Text('push this page again'),
            ),
            RaisedButton(
              onPressed: () {
                final BoostContainerSettings settings =
                    BoostContainer.of(context).settings;
                FlutterBoost.singleton.close(settings.uniqueId,
                    result: <String, dynamic>{'result': 'data from flutter'});
              },
              child: Text('dismiss with result'),
            ),
          ],
        ),
      ),
    );
  }
}
