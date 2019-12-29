//
//  VideoPlayer.m
//  flutter_video_player
//
//  Created by ccj on 2019/6/3.
//

#import "VideoPlayer.h"
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <KTVHTTPCache/KTVHTTPCache.h>

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
    
    VideoPlayerController *viewController = [[VideoPlayerController alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    
    return viewController;
    
    //return nil;
}

@end

@interface VideoPlayerController ()
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
//@property (nonatomic, strong) NSArray <NSURL *>*assetURLs;
@end

@implementation VideoPlayerController{
    int64_t _viewId;
    FlutterMethodChannel* _channel;
    UIView *myView;
    UIView * _videoView;
}

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if ([super init]) {
        
        NSDictionary *dic = args;
        CGFloat x = [dic[@"x"] floatValue];
        CGFloat y = [dic[@"y"] floatValue];
        CGFloat width = [dic[@"width"] floatValue];
        CGFloat height = [dic[@"height"] floatValue];
        
        myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        
        UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        
        [self.view addSubview:containerView];
        
        ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
        
        self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:containerView];
        
        self.player.controlView = self.controlView;
        /// 设置退到后台继续播放
        self.player.pauseWhenAppResignActive = NO;
                

        self.player.orientationDidChanged = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
            if(isFullScreen){
                [[UIApplication sharedApplication] setStatusBarHidden:YES];
            }else{
                [[UIApplication sharedApplication] setStatusBarHidden:NO];
            }
        };
        
        
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

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.prepareShowLoading = YES;
    }
    return _controlView;
}

-(UIView *)view{
    return myView;
}


-(void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result{
    if ([[call method] isEqualToString:@"start"]) {
        NSString* url = call.arguments[@"url"];
        
        [KTVHTTPCache logSetConsoleLogEnable:NO];
        NSError *error = nil;
        [KTVHTTPCache proxyStart:&error];
        if (error) {
            NSLog(@"Proxy Start Failure, %@", error);
        } else {
            NSLog(@"Proxy Start Success");
        }

        NSURL *originalURL = [NSURL URLWithString:url];
        
        
        NSURL *proxyURL = [KTVHTTPCache proxyURLWithOriginalURL:originalURL];


        NSArray <NSURL *> *assetURLs1 = @[proxyURL];

        self.player.assetURLs = assetURLs1;
        [self.player playTheIndex:0];
    }else
        if ([[call method] isEqualToString:@"stop"]){
           // [_indicator stopAnimating];
        }
        else {
            result(FlutterMethodNotImplemented);
        }
}


@end
