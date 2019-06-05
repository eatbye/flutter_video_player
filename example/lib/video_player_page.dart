import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void VideoPlayerPageWidgetCreatedCallback(VideoPlayerPageController controller);

class VideoPlayerPageController {
  VideoPlayerPageController._(int id)
      : _channel = MethodChannel('plugins/video_player_$id');

  final MethodChannel _channel;

  Future<void> start(args) async {
    return _channel.invokeMethod('start',args);
  }
}

class VideoPlayerPage extends StatefulWidget{

  final int x;
  final int y;

  const VideoPlayerPage({
    Key key,
    this.onVideoPlayerPageWidgetCreated,
    this.x,
    this.y,

  }):super(key:key);

  final VideoPlayerPageWidgetCreatedCallback onVideoPlayerPageWidgetCreated;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VideoPlayerPageState();
  }

}

class _VideoPlayerPageState extends State<VideoPlayerPage>{


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);

    if(defaultTargetPlatform == TargetPlatform.iOS){
      return UiKitView(
        viewType: "plugins/video_player",
        onPlatformViewCreated:_onPlatformViewCreated,
        creationParams: <String,dynamic>{
          "x": widget.x,
          "y": widget.y,
          "width": width,
          "height": width*9/16,
          "hidesWhenStopped": true,

        },
        creationParamsCodec: new StandardMessageCodec(),

      );

    }
    return Text('插件尚不支持$defaultTargetPlatform ');
  }

  void _onPlatformViewCreated(int id){
    if(widget.onVideoPlayerPageWidgetCreated == null){
      return;
    }
    widget.onVideoPlayerPageWidgetCreated(new VideoPlayerPageController._(id));
  }

}