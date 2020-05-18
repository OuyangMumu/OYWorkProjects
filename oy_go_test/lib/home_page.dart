/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020-05-02
 */

import 'package:flutter/material.dart';
import 'package:oy_go_test/routes/routeSettings/my_app_routes.dart';
import 'package:provider/provider.dart';

import 'package:oy_go_test/my_app_settings.dart';
import 'package:oy_go_test/routes/routeSettings/my_route.dart';
import 'package:oy_go_test/routes/routeSettings/my_app_routes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const bottomNavBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.library_books),
      title: Text("Basics"),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.insert_chart),
      title: Text("Advanced"),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.indigo,
      icon: Icon(Icons.star),
      title: Text("Bookmarks"),
    ),
  ];
  int _currentTabIndex = 0;


  @override
  Widget build(BuildContext context) {
    final basicDemos = <Widget>[
      for (final MyRouteGroup group in MyAppRoutesBasic)
        _myRouteGroupToExpansionTile(group),
    ];
    final advancedDemos = <Widget>[
      for (final MyRouteGroup group in MyAppRoutesAdvanced)
        _myRouteGroupToExpansionTile(group),
    ];
    final bookmarkAndAboutDemos = <Widget>[
      for (final MyRoute route
      in Provider.of<MyAppSettings>(context).starredRoutes)
        _myRouteToListTitle(route, leading: Icon(Icons.bookmark)),
      _myRouteToListTitle(aboutRoute, leading: Icon(Icons.info)),
    ];
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          ListView(children: basicDemos),
          ListView(children: advancedDemos),
          ListView(children: bookmarkAndAboutDemos),
        ],
        index: _currentTabIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavBarItems,
        currentIndex: _currentTabIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          setState(() => this._currentTabIndex = index);
        },
      ),
    );
  }

  ListTile _myRouteToListTitle(MyRoute route,
      {Widget leading, IconData trialing: Icons.keyboard_arrow_right}) {
    final routeTitleTextStyle = Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold);
    return ListTile(
      leading: leading ??
          Provider.of<MyAppSettings>(context)
              .starStatusOfRoute(route.routeName),
      title: Text(route.title, style: routeTitleTextStyle),
      trailing: trialing == null ? null : Icon(trialing),
      subtitle: route.description == null ? null : Text(route.description),
      onTap: () => Navigator.of(context).pushNamed(route.routeName),
    );
  }

  Widget _myRouteGroupToExpansionTile(MyRouteGroup myRouteGroup) {
    return Card(
      child: ExpansionTile(
        leading: myRouteGroup.icon,
        title: Text(
          myRouteGroup.groupName,
          style: Theme.of(context).textTheme.title,
        ),
        children: myRouteGroup.routes.map(_myRouteToListTitle).toList(),
      ),
    );
  }

}


