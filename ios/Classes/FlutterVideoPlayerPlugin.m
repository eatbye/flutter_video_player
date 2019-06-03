#import "FlutterVideoPlayerPlugin.h"
#import "VideoPlayer.h"

@implementation FlutterVideoPlayerPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_video_player"
            binaryMessenger:[registrar messenger]];
  FlutterVideoPlayerPlugin* instance = [[FlutterVideoPlayerPlugin alloc] init];
    
    [registrar registerViewFactory:[[VideoPlayerFactory alloc] initWithMessenger:registrar.messenger] withId:@"plugins/video_player"];
    
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
