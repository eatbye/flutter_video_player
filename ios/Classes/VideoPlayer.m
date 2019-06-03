//
//  VideoPlayer.m
//  flutter_video_player
//
//  Created by ccj on 2019/6/3.
//

#import "VideoPlayer.h"

#import "SJVideoPlayer.h"


@implementation VideoPlayerFactory{
    NSObject<FlutterBinaryMessenger>*_messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager{
    self = [super init];
    if (self) {
        _messenger = messager;
    }
    return self;
}

-(NSObject<FlutterMessageCodec> *)createArgsCodec{
    return [FlutterStandardMessageCodec sharedInstance];
}

-(NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args{
    
    NSLog(@"==============1");
    VideoPlayerController *viewController = [[VideoPlayerController alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    
    return viewController;
    
    //return nil;
}

@end


@implementation VideoPlayerController{
    int64_t _viewId;
    FlutterMethodChannel* _channel;
    //UIActivityIndicatorView * _indicator;
    UIView *myView;
    UIView * _videoView;
}

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if ([super init]) {
        
        NSDictionary *dic = args;
        //NSString *hexColor = dic[@"hexColor"];
        //bool hidesWhenStopped = [dic[@"hidesWhenStopped"] boolValue];
        NSString *url = dic[@"url"];
        CGFloat x = [dic[@"x"] floatValue];
        CGFloat y = [dic[@"y"] floatValue];
        CGFloat width = [dic[@"width"] floatValue];
        CGFloat height = [dic[@"height"] floatValue];
        
        _videoPlayer = [SJVideoPlayer player];
        //_videoPlayer.view.frame = CGRectMake(0, 20, 300, 400 * 9/16.0);
        _videoPlayer.view.frame = CGRectMake(x, y, width, height);
        _videoPlayer.autoPlayWhenPlayStatusIsReadyToPlay = NO;
        _videoPlayer.controlLayerAutoAppearWhenAssetInitialized = YES;
        _videoPlayer.URLAsset = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:url]];
        
        //[_videoPlayer controlLayerNeedAppear];
        
        //[_videoPlayer needHiddenStatusBar];
        //[_videoPlayer pause];
        myView = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
        //myView.backgroundColor = UIColor.yellowColor;
        
        [myView addSubview:_videoPlayer.view];
        
        _viewId = viewId;
        NSString* channelName = [NSString stringWithFormat:@"plugins/video_player_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        __weak __typeof__(self) weakSelf = self;
        [_channel setMethodCallHandler:^(FlutterMethodCall *  call, FlutterResult  result) {
            [weakSelf onMethodCall:call result:result];
        }];
        
    }
    
    return self;
}

-(UIView *)view{
    return myView;
}


-(void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result{
    if ([[call method] isEqualToString:@"start"]) {
        //[_indicator startAnimating];
    }else
        if ([[call method] isEqualToString:@"stop"]){
           // [_indicator stopAnimating];
        }
        else {
            result(FlutterMethodNotImplemented);
        }
}


@end
