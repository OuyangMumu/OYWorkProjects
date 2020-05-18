/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';

class ListViewBuilderExample extends StatefulWidget {
  const ListViewBuilderExample({Key key}) : super(key: key);
  @override
  _ListViewBuilderExampleState createState() => _ListViewBuilderExampleState();
}

class _ListViewBuilderExampleState extends State<ListViewBuilderExample> {
  final numItems = 20;
  final _biggerFont = const TextStyle(fontSize: 18);
  Widget _buildRow(int idx) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('$idx'),
      ),
      title: Text(
        'Item $idx',
        style: _biggerFont,
      ),
      trailing: Icon(Icons.dashboard),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index.isOdd) return Divider();
        final i = index ~/ 2 + 1;
        return _buildRow(i);
      },
      itemCount: numItems * 2,
      padding: EdgeInsets.all(16),
    );
  }
}
