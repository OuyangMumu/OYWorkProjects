/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020-05-02
 */

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'constant.dart';


class MyAboutRoute extends StatelessWidget {
  const MyAboutRoute({Key key}) : super(key: key);

  static final List<Widget> aboutListTitle = <Widget>[
    ListTile(
      title: Text(APP_DESCRIPTION),
    ),
    Divider(),
    ListTile(
      leading: Icon(Icons.shop),
      title: Text("Rate on Google Play"),
      onTap: () => url_launcher.launch(GOOGLEPLAY_URL),
    ),
    ListTile(
      leading: Icon(Icons.code),
      title: Text('Source code on GitHub'),
      onTap: () => url_launcher.launch(GITHUB_URL),
    ),
    ListTile(
      leading: Icon(Icons.bug_report),
      title: Text('Report issue on GitHub'),
      onTap: () => url_launcher.launch('$GITHUB_URL/issues'),
    ),
    ListTile(
      leading: Icon(Icons.open_in_new),
      title: Text('Visit my website'),
      onTap: () => url_launcher.launch(AUTHOR_SITE),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final hearder = ListTile(
      leading: AppIcon,
      title: Text(APP_NAME),
      subtitle: Text(APP_VERSION),
      trailing: IconButton(
        icon: Icon(Icons.info),
        onPressed: () {
          showAboutDialog(context: context,
              applicationName: APP_NAME,
            applicationVersion: APP_VERSION,
            applicationIcon: AppIcon,
            children: <Widget>[Text(APP_DESCRIPTION)]
          );
        },
      ),
    );

    return ListView(
      children: <Widget>[
        ...aboutListTitle
      ],
    );
  }
}
