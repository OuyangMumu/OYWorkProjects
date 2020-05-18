/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/4
 */

import 'package:flutter/material.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({Key key}) : super(key: key);

  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabPages = <Widget>[
      Center(child: Icon(Icons.cloud, size: 64.0)),
      Center(child: Icon(Icons.alarm, size: 64.0)),
      Center(child: Icon(Icons.forum, size: 64.0)),
    ];
    final bottomNavigationBarItem = [
      BottomNavigationBarItem(icon: Icon(Icons.cloud), title: Text('cloud')),
      BottomNavigationBarItem(icon: Icon(Icons.alarm), title: Text('alarm')),
      BottomNavigationBarItem(icon: Icon(Icons.forum), title: Text('forum')),
    ];
    assert(tabPages.length == bottomNavigationBarItem.length);
    final bottomNavBar = BottomNavigationBar(
      items: bottomNavigationBarItem,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return Scaffold(
      body: tabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
