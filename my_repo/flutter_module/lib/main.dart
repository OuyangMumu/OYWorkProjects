import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/embed_page.dart';
import 'package:flutter_module/native_push_flutter.dart';
import 'package:flutter_module/native_present_flutter.dart';

const EventChannel eventChannel =
    const EventChannel("example.flutter.io/nativeCallFlutter");
const MethodChannel platform =
    const MethodChannel("example.flutter.io/flutterCallNative");

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    print('MyApp_initState');
    FlutterBoost.singleton.registerPageBuilders({
      "NativePushFlutter": (pageName, params, _) =>
          NativePushFlutter(title: params['title']),
      "NativePresentFlutter": (pageName, params, _) =>
          NativePresentFlutter(title: params['title']),
      'embededPage': (pageName, params, _) => EmbeddedFirstRouteWidget(),
    });
    FlutterBoost.singleton
        .addBoostNavigatorObserver(TestBoostNavigatorObserver());
  }

  @override
  Widget build(BuildContext context) {
    print('MyApp_build');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Boost example',
        builder: FlutterBoost.init(postPush: _onRoutePushed),
        // onGenerateRoute: onGenerateRoute,
        home: Container(
          color: Colors.white,
        ));
  }

  void _onRoutePushed(
      String pageName, String uniqueId, Map params, Route route, Future _) {
    _setup(pageName, uniqueId, params, route, _);
  }

  void _setup(
      String pageName, String uniqueId, Map params, Route route, Future _) {}
}

class TestBoostNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didPush');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didPop');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didRemove');
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    print('flutterboost#didReplace');
  }
}
