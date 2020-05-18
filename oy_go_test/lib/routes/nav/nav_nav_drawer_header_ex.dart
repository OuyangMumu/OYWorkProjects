/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/4
 */

import 'package:flutter/material.dart';

class NavDrawerExample extends StatelessWidget {
  const NavDrawerExample({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('User Name'),
      accountEmail: Text('User email'),
      currentAccountPicture: CircleAvatar(
        child: FlutterLogo(size: 42),
        backgroundColor: Colors.redAccent,
      ),
      otherAccountsPictures: <Widget>[
        CircleAvatar(child: Text('A'), backgroundColor: Colors.green),
        CircleAvatar(child: Text('B'), backgroundColor: Colors.green)
      ],
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text('TO Page1'),
          onTap: () {
            Navigator.push(context, _NewPage(1));
          },
        ),
        ListTile(
          title: Text('To page 2'),
          onTap: () => Navigator.of(context).push(_NewPage(2)),
        ),
        ListTile(
          title: Text('other drawer item'),
          onTap: () {},
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer example'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Text('Swip ro click upper - left'),
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}

// <Null> means this route returns nothing.
class _NewPage extends MaterialPageRoute<Null> {
  _NewPage(int id)
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Page $id'),
              elevation: 1.0,
            ),
            body: Center(
              child: Text('Page $id'),
            ),
          );
        });
}
