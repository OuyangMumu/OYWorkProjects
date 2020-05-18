import 'package:backdrop/backdrop.dart';
/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020-05-02
 */

import 'package:flutter/material.dart';
import 'package:oy_go_test/my_app_settings.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:widget_with_codeview/widget_with_codeview.dart';
import 'package:oy_go_test/constant.dart';
import 'package:oy_go_test/about.dart';

class MyRoute extends StatelessWidget {
  static const frontLayerMinHeight = 128.0;

  final String sourceFilePath;

  final Widget child;

  final String _title;

  final String description;

  final Map<String, String> links;

  final String _routeName;

  const MyRoute({Key key,
    @required this.sourceFilePath,
    @required this.child,
    String title,
    String routeName,
    this.description,
    this.links})
      : _title = title,
        _routeName = routeName,
        super(key: key);

  String get routeName {
    return this._routeName ?? '/${this.child.runtimeType.toString()}';
  }

  String get title {
    return this._title ?? this.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(this.title),
        ),
        actions: _getAppBarActions(context),
        iconPosition: BackdropIconPosition.action,
        headerHeight: frontLayerMinHeight,
        frontLayer: Builder(builder: (BuildContext context) {
          return routeName == Navigator.defaultRouteName ? this.child : WidgetWithCodeView(
            child: this.child,
            sourceFilePath: this.sourceFilePath,
            codeLinkPrefix: '$GITHUB_URL/blob/master',
          );
        }),
      backLayer: _getBackdropListTitles(),
    );
  }

  List<Widget> _getAppBarActions(BuildContext context) {
    final settings = Provider.of<MyAppSettings>(context);
    return <Widget>[
      if (this.routeName == Navigator.defaultRouteName)
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
//            final String selected = await
          },
        ),
      if (this.routeName != Navigator.defaultRouteName)
        settings.starStatusOfRoute(this.routeName),
      if (this.links?.isNotEmpty ?? false)
        PopupMenuButton(
          itemBuilder: (context) {
            return <PopupMenuItem>[
              for (MapEntry<String, String> titleAndLink in this.links.entries)
                PopupMenuItem(
                  child: ListTile(
                    title: Text(titleAndLink.key),
                    trailing: IconButton(
                      icon: Icon(Icons.open_in_new),
                      tooltip: '${titleAndLink.value}',
                      onPressed: () {
                        url_launcher.launch(titleAndLink.value);
                      },
                    ),
                    onTap: () {
                      url_launcher.launch(titleAndLink.value);
                    },
                  ),
                )
            ];
          },
        ),
    ];
  }


  ListView _getBackdropListTitles() {
    return ListView(
      padding: EdgeInsets.only(bottom: frontLayerMinHeight),
      children: <Widget>[
        ListTile(
          leading: AppIcon,
          title: Text(APP_NAME),
          subtitle: Text(APP_VERSION),
        ),
        ...MyAboutRoute.aboutListTitle,
        Consumer<MyAppSettings>(builder: (context, MyAppSettings settings, _) {
          return ListTile(
            onTap: () {},
            leading: Icon(
                settings.isDarkMode ? Icons.brightness_4 : Icons.brightness_7),
            title: Text("Dark Mode"),
            trailing: Switch(
              onChanged: (bool value) {
                settings.setDarkMode(value);
              },value: settings.isDarkMode,
            ),
          );
        },
        )
      ],
    );
  }
}
