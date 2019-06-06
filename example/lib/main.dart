import 'package:flutter/material.dart';
import 'video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoPlayerPageController controller;
  bool isPlaying = false;

  void _onVideoPlayerPageControllerCreated(
      VideoPlayerPageController _controller) {
    controller = _controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('视频播放演示'),
      ),
      body: mainWidget(context),
    );
  }

  Column mainWidget(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        playerWidget(width),
      ],
    );
  }

  Container playerWidget(double width) {
    return Container(
      width: width,
      height: width * 9 / 16,
      child: GestureDetector(
        onTap: () {
          isPlaying = true;
          setState(() {});
          controller.start(<String, dynamic>{
            'url':
                'https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4',
          });
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              width: width,
              height: width * 9 / 16,
              child: VideoPlayer(
                x: 0,
                y: 0,
                width: width.toInt(),
                height: (width * 9 / 16).toInt(),
                onVideoPlayerPageWidgetCreated:
                    _onVideoPlayerPageControllerCreated,
              ),
            ),
            isPlaying == false
                ? Image.network(
                    'https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240')
                : Container(),
            isPlaying == false
                ? Positioned(
                    child: Icon(
                    Icons.play_circle_outline,
                    size: 60,
                    color: Colors.white,
                  ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
