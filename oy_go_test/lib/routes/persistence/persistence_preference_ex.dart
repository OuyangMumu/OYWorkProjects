/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/4
 */

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceExample extends StatefulWidget {
  const SharedPreferenceExample({Key key}) : super(key: key);

  @override
  _SharedPreferenceExampleState createState() =>
      _SharedPreferenceExampleState();
}

class _SharedPreferenceExampleState extends State<SharedPreferenceExample> {
  SharedPreferences _preferences;
  static const String demoNumberPrefKey = 'demo_number_pref';
  static const String demoBooleanPrefKey = 'demo_boolean_pref';
  int _numberPref = 0;
  bool _boolPref = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
      ..then((pref) {
        setState(() {
          this._preferences = pref;
        });
        _loadNumberPref();
        _loadBooleanPref();
      });
  }

  void _loadNumberPref() {
    setState(() {
      this._numberPref = this._preferences.getInt(demoNumberPrefKey) ?? 0;
    });
  }

  void _loadBooleanPref() {
    setState(() {
      this._boolPref = this._preferences.getBool(demoBooleanPrefKey) ?? false;
    });
  }

  Future<Null> _setNumberPref(int val) async {
    await this._preferences.setInt(demoNumberPrefKey, val);
    _loadNumberPref();
  }

  Future<Null> _setBooleanPref(bool val) async {
    await this._preferences.setBool(demoBooleanPrefKey, val);
    _loadBooleanPref();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(children: [
          Text('Number preference'),
          Text('${this._numberPref}'),
          RaisedButton(
            child: Text('Increment'),
            onPressed: () {
              this._setNumberPref(this._numberPref + 1);
            },
          )
        ]),
        TableRow(
          children: <Widget>[
            Text('Boolean preference:'),
            Text('${this._boolPref}'),
            RaisedButton(
              child: Text('Toggle'),
              onPressed: () => this._setBooleanPref(!this._boolPref),
            ),
          ],
        ),
      ],
    );
  }
}
