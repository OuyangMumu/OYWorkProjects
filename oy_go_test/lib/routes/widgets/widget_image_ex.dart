import 'dart:ui';

/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/3
 */

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageExample extends StatefulWidget {
  const ImageExample({Key key}) : super(key: key);
  @override
  _ImageExampleState createState() => _ImageExampleState();
}

class _ImageExampleState extends State<ImageExample> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      children: <Widget>[
        ListTile(
          title: Text("Image from asset:"),
        ),
        Card(
          child: Image.asset('res/images/dart-side.png'),
        ),
        Divider(),
        ListTile(
          title: Text("Image form url:"),
        ),
        Card(
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image:
                  "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1588467540&di=e4cd0d9f0d9918a5c940b8f9d20d14cf&src=http://a3.att.hudong.com/14/75/01300000164186121366756803686.jpg"),
        ),
        Divider(),
        ListTile(
          title: Text("Image from Gift"),
        ),
        Card(
          child: Image.asset(
            'res/images/animated_flutter_lgtm.gif',
            scale: 0.5,
            height: 200,
          ),
        ),
        Divider(),
        ListTile(
          title: Text("Image from package in asset WEBP"),
        ),
        Image.asset(
          'animated_images/animated_flutter_stickers.webp',
          package: "flutter_gallery_assets",
        )
      ],
    );
  }
}
