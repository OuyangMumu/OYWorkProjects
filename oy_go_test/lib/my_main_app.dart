/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020-05-01
 */

import 'package:flutter/material.dart';
import 'package:oy_go_test/my_app_settings.dart';
import 'package:oy_go_test/routes/routeSettings/my_app_routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:oy_go_test/themes.dart';
import 'package:oy_go_test/constant.dart';
import 'r.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (!snapshot.hasData) {
          return _MySplashScreen();
        }
        return ChangeNotifierProvider<MyAppSettings>.value(
          value: MyAppSettings(snapshot.data),
          child: _MyMainApp(),
        );
      },
    );
  }
}

class _MySplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Image.asset(R.resImagesAnimatedFlutterLgtm));
  }
}

class _MyMainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Catalog",
      theme: Provider.of<MyAppSettings>(context).isDarkMode
          ? darkTheme
          : lightThemme,
      routes: AppRoutingTabel,
    );
  }
}
