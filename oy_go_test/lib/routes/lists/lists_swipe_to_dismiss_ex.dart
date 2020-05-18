/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';

class ListSwipeToDismissExample extends StatefulWidget {
  const ListSwipeToDismissExample({Key key}) : super(key: key);
  @override
  _ListSwipeToDismissExampleState createState() =>
      _ListSwipeToDismissExampleState();
}

class _ListSwipeToDismissExampleState extends State<ListSwipeToDismissExample> {
  final _items = List.generate(20, (index) {
    return "Item + ${index + 1}";
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int i) {
        final String item = _items[i];
        return Dismissible(
          key: Key(item),
          onDismissed: (DismissDirection dir) {
            setState(() {
              this._items.removeAt(i);
            });
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(dir == DismissDirection.startToEnd
                    ? '$item removed'
                    : '$item like'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    setState(() {
                      this._items.insert(i, item);
                    });
                  },
                ),
              ),
            );
          },
          background: Container(
            color: Colors.red,
            child: Icon(Icons.delete),
            alignment: Alignment.centerLeft,
          ),
          secondaryBackground: Container(
            color: Colors.green,
            child: Icon(Icons.thumb_up),
            alignment: Alignment.centerRight,
          ),
          child: ListTile(
            title: Center(child: Text('${_items[i]}')),
          ),
        );
      },
      itemCount: _items.length,
    );
  }
}
