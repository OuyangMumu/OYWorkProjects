import 'dart:convert';

/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/5
 */

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestApiSendExample extends StatefulWidget {
  const RestApiSendExample({Key key}) : super(key: key);
  @override
  _RestApiSendExampleState createState() => _RestApiSendExampleState();
}

class _RestApiSendExampleState extends State<RestApiSendExample> {
  TextEditingController _titleController;
  TextEditingController _contentController;
  TextEditingController _userIdController;
  String _responseBody = '<empty>';
  String _error = '<none>';
  bool _pending = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._titleController = TextEditingController();
    this._contentController = TextEditingController();
    this._userIdController = TextEditingController();
    _reset();
  }

  void _reset({bool resetController = true}) {
    setState(() {
      if (resetController) {
        this._titleController.text = 'Lorem Ipsum Title';
        this._contentController.text =
            '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Egestas congue quisque egestas diam in arcu. 
        Quis imperdiet massa tincidunt nunc pulvinar. ''';
        this._userIdController.text = '1';
      }
      this._responseBody = '<empty>';
      this._error = '<none>';
      this._pending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        Text('''In this example we will POST to the jsonplaceholder API.
    From https://jsonplaceholder.typicode.com/guide.html we see that the API expects title, body and userId in the request body.'''),
        Divider(),
        TextField(
          controller: this._titleController,
          decoration: InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: this._contentController,
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'content',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: this._userIdController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'UserId',
            border: OutlineInputBorder(),
          ),
        ),
        ButtonBar(
          children: <Widget>[
            RaisedButton(
              child: Text('POST'),
              onPressed: _pending
                  ? null
                  : () {
                      _httpPost(
                        this._titleController.text,
                        this._contentController.text,
                        this._userIdController.text,
                      );
                    },
            ),
            RaisedButton(
              child: Text('REST'),
              onPressed: _reset,
            ),
          ],
        ),
        Text('Response body = ${_responseBody}'),
        Divider(),
        Text('Error = ${_error}'),
      ],
    );
  }

  Future<void> _httpPost(String title, String body, String userId) async {
    _reset(resetController: false);
    setState(() {
      this._pending = true;
    });
    try {
      final http.Response response =
          await http.post('https://jsonplaceholder.typicode.com/posts',
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{
                'title': title,
                'body': body,
                'userId': userId,
              }));
      if (response.statusCode == 201) {
        setState(() => this._responseBody = response.body);
      } else {
        setState(
            () => this._error = 'Failed to add a post: ' + response.toString());
      }
    } catch (e) {
      setState(() => this._error = 'Failed to add a post: $e');
    }
    setState(() => this._pending = false);
  }
}
