/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BottomAppbarExample extends StatefulWidget {
  const BottomAppbarExample({Key key}) : super(key: key);
  @override
  _BottomAppbarExampleState createState() => _BottomAppbarExampleState();
}

class _BottomAppbarExampleState extends State<BottomAppbarExample> {
  FloatingActionButtonLocation _floatingActionButtonLocation =
      FloatingActionButtonLocation.endDocked;

  bool isBottomBarNotched = false;
  bool isFabMini = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            title: Text('FloatingActionButton position:'),
            trailing: DropdownButton<FloatingActionButtonLocation>(
              value: this._floatingActionButtonLocation,
              onChanged: (FloatingActionButtonLocation location) {
                if (location != null) {
                  setState(() {
                    this._floatingActionButtonLocation = location;
                  });
                }
              },
              items: [
                DropdownMenuItem(
                  value: FloatingActionButtonLocation.centerFloat,
                  child: Text('centerFloat'),
                ),
                DropdownMenuItem(
                  value: FloatingActionButtonLocation.endFloat,
                  child: Text('endFloat'),
                ),
                DropdownMenuItem(
                  value: FloatingActionButtonLocation.centerDocked,
                  child: Text('centerDocked'),
                ),
                DropdownMenuItem(
                  value: FloatingActionButtonLocation.endDocked,
                  child: Text('endDocked'),
                ),
                DropdownMenuItem(
                  value: FloatingActionButtonLocation.miniStartTop,
                  child: Text('miniStartTop'),
                ),
                DropdownMenuItem(
                  value: FloatingActionButtonLocation.startTop,
                  child: Text('startTop'),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Mini FAB'),
            trailing: Switch(
                value: this.isFabMini,
                onChanged: (value) {
                  setState(() {
                    this.isFabMini = value;
                  });
                }),
          ),
          ListTile(
            title: Text('BottomAppBar notch:'),
            trailing: Switch(
                value: this.isBottomBarNotched,
                onChanged: (value) {
                  setState(() {
                    this.isBottomBarNotched = value;
                  });
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Fluttertoast.showToast(msg: 'Dummy floating action button');
        },
        child: Icon(Icons.add),
        mini: this.isFabMini,
      ),
      floatingActionButtonLocation: this._floatingActionButtonLocation,
      bottomNavigationBar: this._buildBottomAppBar(context),
    );
  }

  BottomAppBar _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      shape: this.isBottomBarNotched ? CircularNotchedRectangle() : null,
      color: Theme.of(context).primaryColor,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      alignment: Alignment.center,
                      height: 200,
                      child: Text('Dummy bottom sheet'),
                    );
                  });
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Fluttertoast.showToast(msg: 'Dummy search action.');
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => Fluttertoast.showToast(msg: 'Dummy menu action.'),
          ),
        ],
      ),
    );
  }
}
