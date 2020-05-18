/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';

class ReorderableListExample extends StatefulWidget {
  const ReorderableListExample({Key key}) : super(key: key);
  @override
  _ReorderableListExampleState createState() => _ReorderableListExampleState();
}

class _ReorderableListExampleState extends State<ReorderableListExample> {
  bool _reverseSort = false;
  static final _items = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
  ].map((item) => _ListItem(item, false)).toList();

  void _onRecorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final _ListItem item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  void _onSort() {
    setState(() {
      _reverseSort = !_reverseSort;
      _items.sort((_ListItem a, _ListItem b) {
        return _reverseSort
            ? b.value.compareTo(a.value)
            : a.value.compareTo(b.value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appbar = AppBar(
      title: Text('Reorderable list'),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.sort_by_alpha),
          tooltip: 'Sort',
          onPressed: _onSort,
        ),
      ],
    );
    final _listTitles = _items
        .map((item) => CheckboxListTile(
              key: Key(item.value),
              value: item.checked ?? false,
              onChanged: (newVal) {
                setState(() {
                  item.checked = newVal;
                });
              },
              title: Text('This item represent ${item.value}'),
              isThreeLine: true,
              subtitle: Text('Item ${item.value}, check ${item.checked}'),
              secondary: Icon(Icons.drag_handle),
            ))
        .toList();
    return Scaffold(
      appBar: _appbar,
      body: ReorderableListView(
        onReorder: _onRecorder,
        children: _listTitles,
      ),
    );
  }
}

class _ListItem {
  final String value;
  bool checked;

  _ListItem(this.value, this.checked);
}
