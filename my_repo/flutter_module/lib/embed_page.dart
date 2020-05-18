import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

class EmbeddedFirstRouteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmbeddedFirstRouteWidgetState();
}

class _EmbeddedFirstRouteWidgetState extends State<EmbeddedFirstRouteWidget> {
  @override
  Widget build(BuildContext context) {
    print('_EmbededFirstRouteWidgetState build called!');
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: const Text('Open flutter page'),
          onPressed: () {
            FlutterBoost.singleton.open('NativePushFlutter',
                exts: {'animated': true}).then((Map<dynamic, dynamic> value) {
              print(
                  'call me when page is finished. did recieve second route result $value');
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('[XDEBUG]:_EmbededFirstRouteWidgetState disposing~');
    super.dispose();
  }
}
