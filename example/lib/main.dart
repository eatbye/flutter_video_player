import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'video_player_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  VideoPlayerPageController controller;

  void _onVideoPlayerPageControllerCreated(VideoPlayerPageController _controller){
    controller = _controller;
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();

  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: VideoPlayerPage(
              x: 0, y: 0,
              onVideoPlayerPageWidgetCreated: _onVideoPlayerPageControllerCreated,
              ),
            ),
            FlatButton(child: Text('播放'),onPressed: (){
              controller.start(<String, dynamic>{
                'url': 'https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4',
              });
            },)

          ],
        )
      ),
    );
  }
}
