/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/4
 */

import 'package:flutter/material.dart';

class BottomTabbarExample extends StatefulWidget {
  const BottomTabbarExample({Key key}) : super(key: key);
  @override
  _BottomTabbarExampleState createState() => _BottomTabbarExampleState();
}

class _BottomTabbarExampleState extends State<BottomTabbarExample>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  static const tabPages = <Widget>[
    Center(child: Icon(Icons.cloud, size: 64)),
    Center(child: Icon(Icons.alarm, size: 64)),
    Center(child: Icon(Icons.forum, size: 64)),
  ];
  static const tabs = <Tab>[
    Tab(icon: Icon(Icons.cloud), text: 'Tab1'),
    Tab(icon: Icon(Icons.alarm), text: 'Tab1'),
    Tab(icon: Icon(Icons.forum), text: 'Tab1'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabPages.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: TabBarView(
          children: tabPages,
          controller: _tabController,
        ),
        bottomNavigationBar: Material(
          color: Colors.blue,
          child: TabBar(tabs: tabs, controller: _tabController),
        ));
  }
}
