//
//  VideoPlayer.h
//  flutter_video_player
//
//  Created by ccj on 2019/6/3.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerController : NSObject<FlutterPlatformView>

- (instancetype)initWithWithFrame:(CGRect)frame
                   viewIdentifier:(int64_t)viewId
                        arguments:(id _Nullable)args
                  binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;



@end

@interface VideoPlayerFactory : NSObject<FlutterPlatformViewFactory>


- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messager;

@end
NS_ASSUME_NONNULL_END
