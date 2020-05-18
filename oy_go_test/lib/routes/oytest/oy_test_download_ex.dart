/**
 * Created with Android Studio.
 * @author gaojun
 * @e-mail 804716454@qq.com
 * @time   2020/5/5
 */

import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';

class DownLoadExample extends StatefulWidget {
  const DownLoadExample({Key key}) : super(key: key);
  @override
  _DownLoadExampleState createState() => _DownLoadExampleState();
}

class _DownLoadExampleState extends State<DownLoadExample>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final fileUrl = 'http://music.163.com/song/media/outer/url?id=413829859.mp3';
  bool downloading = false;
  double progerss;
  var path = 'No Data';
  var platformVersion = 'Unknown';
  Permission permission1 = Permission.WriteExternalStorage;
  var _onPressed;
  static final Random random = Random();
  Directory externalDir;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    onAnimationStart();
  }

  void onAnimationStart() {
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(width: size.width, height: 100),
          Text('//线性进度条进度动画'),
          Padding(
            padding: EdgeInsets.all(16),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: ColorTween(begin: Colors.grey, end: Colors.red)
                  .animate(_controller),
              value: _controller.value,
            ),
          ),
          Text('//线性进度条模糊动画'),
          Padding(
            padding: EdgeInsets.all(16),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
          Text('////精准进度'),
          Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: ColorTween(begin: Colors.grey, end: Colors.red)
                  .animate(_controller),
              value: _controller.value,
            ),
          ),
          Text('//模糊进度条(会执行一个旋转动画)'),
          Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
          SizedBox(height: 20),
          Center(
              child: downloading
                  ? Container(
                      height: 200,
                      width: 200,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey[200],
                            value: progerss,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('下载文件路径:${path}'),
                        MaterialButton(
                          child: Text('开始下载'),
                          onPressed: () {
                            downloadFile();
                          },
                          disabledColor: Colors.blueGrey,
                          color: Colors.pink,
                          textColor: Colors.white,
                          height: 40,
                          minWidth: 100,
                        )
                      ],
                    )),
        ],
      ),
    );
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    bool checkPermission1 =
        await SimplePermissions.checkPermission(permission1);
    if (checkPermission1 == false) {
      await SimplePermissions.requestPermission(permission1);
      checkPermission1 = await SimplePermissions.checkPermission(permission1);
    }
    if (checkPermission1 == true) {
      String dirloc = '';
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }
      var randid = random.nextInt(10000);
      print(dirloc);
      try {
        FileUtils.mkdir([dirloc]);
        await dio.download(fileUrl, dirloc + randid.toString() + '.mp3',
            onReceiveProgress: (reveivedBytes, totalBytes) {
          setState(() {
            downloading = true;
            progerss = reveivedBytes / totalBytes;
          });
        });
      } catch (e) {}
    }
  }
}
