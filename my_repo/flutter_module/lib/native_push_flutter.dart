import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter/cupertino.dart';

class NativePushFlutter extends StatefulWidget {
  final String title;
  NativePushFlutter({Key key, this.title}) : super(key: key);

  @override
  _NativePushFlutterState createState() => _NativePushFlutterState();
}

class _NativePushFlutterState extends State<NativePushFlutter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return NativePushFlutter(
                    title: "flutter push self again",
                  );
                }));
              },
              child: Text('push this page by flutter nav'),
            ),
            RaisedButton(
              onPressed: () {
                FlutterBoost.singleton.open('NativePushFlutter',
                    urlParams: {'title': 'Native push self again'},
                    exts: {'animated': true});
              },
              child: Text('push this page by Native nav'),
            ),
            RaisedButton(
              /// 后面的参数会在native的IPlatform.startActivity方法回调中拼接到url的query部分。
              /// 例如：sample://nativePage?aaa=bbb
              onPressed: () => FlutterBoost.singleton.open(
                'Native//UIViewController',
                urlParams: <String, dynamic>{
                  'query': <String, dynamic>{'aaa': 'bbb'}
                },
              ),
              child: Text('push to native'),
            ),
            RaisedButton(
              onPressed: () {
                final BoostContainerSettings settings =
                    BoostContainer.of(context).settings;
                FlutterBoost.singleton.close(settings.uniqueId,
                    result: <String, dynamic>{'result': 'data from flutter'});
              },
              child: Text('pop with result'),
            ),
          ],
        ),
      ),
    );
  }
}
