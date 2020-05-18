import 'package:flutter/foundation.dart';
/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/5
 */

import 'package:flutter/material.dart';
import 'package:oy_go_test/routes/plugins/http_error.dart';
import 'package:oy_go_test/routes/plugins/http_manager.dart';

class RestApiFetchExample extends StatefulWidget {
  const RestApiFetchExample({Key key}) : super(key: key);

  @override
  _RestApiFetchExampleState createState() => _RestApiFetchExampleState();
}

class _RestApiFetchExampleState extends State<RestApiFetchExample> {
  TextEditingController _urlEditingController;
  TextEditingController _apiEditinngController;
  String _responseBody = '<empty>';
  String _error = '<empty>';
  bool _pending = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._urlEditingController = TextEditingController()
      ..text = 'https://jsonplaceholder.typicode.com/posts/1';
    this._apiEditinngController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        TextField(
          controller: this._urlEditingController,
          decoration: InputDecoration(
              labelText: 'Url to get', border: OutlineInputBorder()),
        ),
        SizedBox(height: 40),
        TextField(
          controller: this._apiEditinngController,
          decoration: InputDecoration(
            labelText: 'Optional api token',
            border: OutlineInputBorder(),
          ),
        ),
        ButtonBar(
          children: <Widget>[
            RaisedButton(
              child: Text('GET'),
              onPressed: _pending
                  ? null
                  : () {
                      _httpGet(this._urlEditingController.text,
                          _apiEditinngController.text);
                    },
            ),
            RaisedButton(
              child: Text('Reset'),
              onPressed: this._reset,
            )
          ],
        ),
        Text('Response body:${_responseBody}'),
        Divider(),
        Text('Error:{$_error}')
      ],
    );
  }

  void _reset({bool resetController = true}) {
    setState(() {
      if (resetController) {
        this._urlEditingController.text =
            'https://jsonplaceholder.typicode.com/posts/1';
      }
      this._responseBody = '<empty>';
      this._error = '<empty>';
      this._pending = false;
    });
  }

//  Future<Null> _httpGet(String url, String aipToken) async {
//    _reset();
//    setState(() {
//      this._pending = true;
//    });
//    try {
//      final http.Response response = await http.get(url, headers: {
//        HttpHeaders.authorizationHeader: aipToken,
//      });
//      final parsed = await compute(jsonDecode, response.body);
//      print('parsed json object=$parsed');
//      setState(() {
//        this._responseBody = response.body;
//      });
//    } catch (e) {
//      setState(() {
//        this._error = e.toString();
//      });
//    }
//    setState(() {
//      this._pending = false;
//    });
//  }
  Future<Null> _httpGet(String url, String aipToken) async {
    HttpManager().init(baseUrl: 'https://jsonplaceholder.typicode.com/posts/1');
    HttpManager().get(
        url: 'https://jsonplaceholder.typicode.com/posts/1',
        tag: '1',
        successCallback: (data) {
          setState(() {
            this._responseBody = data.toString();
          });
        },
        failureCallback: (HttpError e) {
          this._error = e.toString();
        });
  }
}
