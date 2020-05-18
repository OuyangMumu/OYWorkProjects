/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/4
 */

import 'package:flutter/material.dart';

class TabsExample extends StatelessWidget {
  const TabsExample({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tabPages = <Widget>[
      Center(
        child: Icon(
          Icons.cloud,
          size: 64,
          color: Colors.teal,
        ),
      ),
      Center(
        child: Icon(
          Icons.alarm,
          size: 64,
          color: Colors.cyan,
        ),
      ),
      Center(
        child: Icon(
          Icons.forum,
          size: 64,
          color: Colors.blue,
        ),
      ),
    ];
    final tabs = <Tab>[
      Tab(
        icon: Icon(Icons.cloud),
//        text: 'Tab1',
        child: Icon(Icons.settings),
      ),
      Tab(
        icon: Icon(Icons.alarm),
        text: 'Tab2',
      ),
      Tab(
        icon: Icon(Icons.forum),
        text: 'Tab3',
      ),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Appbar title'),
          backgroundColor: Colors.cyan,
          bottom: TabBar(
            tabs: tabs,
            indicatorColor: Colors.red,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.yellow,
          ),
        ),
        body: TabBarView(children: tabPages),
      ),
    );
  }
}
