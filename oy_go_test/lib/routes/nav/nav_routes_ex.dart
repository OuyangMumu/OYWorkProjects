/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/4
 */

import 'package:flutter/material.dart';

class RoutesExample extends StatelessWidget {
  const RoutesExample({Key key}) : super(key: key);

  static const routeName = '/RoutesExample';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Page1'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.push(context, _PageTwo());
          },
          child: Text('Go to Page2'),
        ),
      ),
    );
  }
}

class _PageTwo extends MaterialPageRoute<Null> {
  _PageTwo()
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Page2'),
              elevation: 1.0,
            ),
            body: Builder(
              builder: (BuildContext context) {
                return Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context, _PageThree()).then((returnVal) {
                        if (returnVal != null) {
                          Scaffold.of(context).removeCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('You clicked: $returnVal'),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {},
                              ),
                            ),
                          );
                        }
                      });
                    },
                    child: Text('Go to Page3'),
                  ),
                );
              },
            ),
          );
        });
}

// MaterialPageRoute<String> returns a Future<String>.
class _PageThree extends MaterialPageRoute<String> {
  _PageThree()
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Last page'),
              elevation: 2.0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(32.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(child: Text('1')),
                    title: Text('user1@example.com'),
                    onTap: () => Navigator.pop(context, 'user1@example.com'),
                  ),
                  ListTile(
                    leading: CircleAvatar(child: Text('2')),
                    title: Text('user2@example.com'),
                    onTap: () => Navigator.pop(context, 'user2@example.com'),
                  ),
                  ListTile(
                    leading: CircleAvatar(child: Text('3')),
                    title: Text('user3@example.com'),
                    onTap: () => Navigator.pop(context, 'user3@example.com'),
                  ),
                  Divider(),
                  MaterialButton(
                    child: Text('Go home'),
                    onPressed: () {
                      // Pops until reaching a route with that route name.
                      Navigator.popUntil(
                          context, ModalRoute.withName("/_PageTwo"));
                    },
                  ),
                ],
              ),
            ),
          );
        });
}
