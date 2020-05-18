/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';

class RowColExample extends StatefulWidget {
  const RowColExample({Key key}) : super(key: key);
  @override
  _RowColExampleState createState() => _RowColExampleState();
}

class _RowColExampleState extends State<RowColExample> {
  static const elements = <Widget>[
    Icon(
      Icons.star,
      size: 50,
    ),
    Icon(
      Icons.star,
      size: 100,
    ),
    Icon(
      Icons.star,
      size: 50,
    ),
  ];

  bool _isRow = true;
  MainAxisSize _mainAxisSize = MainAxisSize.max;
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.start;

  @override
  Widget build(BuildContext context) {
    final appbarButton = getBottomBar();
    return Scaffold(
      body: buildBody(),
      bottomNavigationBar: appbarButton,
    );
  }

  Widget buildBody() => Container(
        color: Colors.yellow,
        child: _isRow
            ? Row(
                mainAxisAlignment: _mainAxisAlignment,
                crossAxisAlignment: _crossAxisAlignment,
                mainAxisSize: _mainAxisSize,
                children: elements,
              )
            : Column(
                mainAxisSize: _mainAxisSize,
                mainAxisAlignment: _mainAxisAlignment,
                crossAxisAlignment: _crossAxisAlignment,
                children: elements,
              ),
      );
  Widget getBottomBar() {
    return Material(
      color: Theme.of(context).primaryColorLight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Radio(
                value: true,
                groupValue: this._isRow,
                onChanged: (value) {
                  setState(() {
                    this._isRow = value;
                  });
                },
              ),
              Text('Row'),
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                  value: false,
                  groupValue: this._isRow,
                  onChanged: (value) {
                    setState(() {
                      this._isRow = value;
                    });
                  }),
              Text('Column')
            ],
          ),
          ListTile(
            title: Text("mainAxiSize"),
            trailing: DropdownButton(
                value: this._mainAxisSize,
                items: MainAxisSize.values.map((MainAxisSize value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                        value.toString().substring('MainAxisSize.'.length)),
                  );
                }).toList(),
                onChanged: (MainAxisSize newVal) {
                  if (newVal != null) {
                    setState(() => this._mainAxisSize = newVal);
                  }
                }),
          ),
          ListTile(
            title: Text('mainAxisAlignment:'),
            trailing: DropdownButton(
                value: _mainAxisAlignment,
                items: MainAxisAlignment.values
                    .map((MainAxisAlignment value) => DropdownMenuItem(
                          value: value,
                          child: Text(value
                              .toString()
                              .substring('MainAxisAlignment.'.length)),
                        ))
                    .toList(),
                onChanged: (MainAxisAlignment newVal) {
                  if (newVal != null) {
                    setState(() {
                      this._mainAxisAlignment = newVal;
                    });
                  }
                }),
          ),
          ListTile(
            title: Text('crossAxisAlignment:'),
            trailing: DropdownButton<CrossAxisAlignment>(
              value: _crossAxisAlignment,
              onChanged: (CrossAxisAlignment newVal) {
                if (newVal != null) {
                  setState(() => this._crossAxisAlignment = newVal);
                }
              },
              items: CrossAxisAlignment.values
                  .map((CrossAxisAlignment val) => DropdownMenuItem(
                        value: val,
                        child: Text(val
                            .toString()
                            .substring('CrossAxisAlignment.'.length)),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
