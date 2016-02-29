//
//  MusicPlayManager.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "MusicPlayManager.h"
#import <AVFoundation/AVFoundation.h>
#import "playMusicModel.h"
#define PlayMusicURL @"http://mobile.ximalaya.com/mobile/track/detail?device=android&trackId="
static MusicPlayManager *manager= nil;

@interface MusicPlayManager ()
//播放器
@property (nonatomic, strong)AVPlayer *musicPlayer;

@property (nonatomic, strong) NSTimer *timer;
@property(nonatomic,strong)NSMutableArray *playMusicDataArray;
@end
@implementation MusicPlayManager

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [MusicPlayManager new];
    });
    return manager;
}

- (instancetype)init{
    self.musicPlayer = [AVPlayer new];
    //起始状态为暂停
//    self.state = 0;
    
//    //注册播放结束的通知 播放状态
//    [[NSNotificationCenter defaultCenter]addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    //注册结束的通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    return self;
    
}
#pragma mark 播放结束
//- (void)playEnd
//{
//    self.state = NO;
//    if (self.playDelegate && [self.playDelegate respondsToSelector:@selector(playEndToTime)]) {
//        //让代理去执行协议方法
//        [self.playDelegate playEndToTime];
//        
//    }
//}
#pragma mark 从指定时间进行播放
//- (void)seekTimeToPlay:(float)Value{
//    //当你滑动时先暂停
//    [self pause];
//    //传递指定时间和单位 转换成 CMTime
//    //第一个参数是当前第几帧
//    //    CMTime timeValue = CMTimeMake((int)Value, self.musicPlayer.currentTime.timescale);
//    
//    //单位是秒 第一个参数是当前时间
//    CMTime timeValue = CMTimeMakeWithSeconds(Value, self.musicPlayer.currentTime.timescale);
//    [self.musicPlayer seekToTime:timeValue completionHandler:^(BOOL finished) {
//        if (finished == YES) {
//            [self play];
//        }
//    }];
//}

#pragma mark 设置唱片 准备播放

-(void)downLoadDataFinished:(void(^)())result2 withPlayModel:(detailTableViewModel *)model
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSString *playURL = [NSString stringWithFormat:@"%@%@",PlayMusicURL, model.trackId];
        //   NSLog(@"----------%@",playURL);
        NSURL *url = [NSURL URLWithString:playURL];
        
        NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            self.model = [[playMusicModel alloc]init];
            [self.model setValuesForKeysWithDictionary:result];
            //  NSLog(@"==========%@",self.model.intro);
            [self.playMusicDataArray addObject:model];
            dispatch_async(dispatch_get_main_queue(), ^{
                result2();
            });
        }];
        
        [task resume];
    });
    
}
-(NSMutableArray *)playMusicDataArray
{
    if (!_playMusicDataArray)
    {
        _playMusicDataArray = [NSMutableArray array];
    }
    return _playMusicDataArray;
}

-(NSArray *)playMusicArray
{
    
    return [self.playMusicDataArray copy];
}

#pragma mark 播放
//- (void)play{
//    if (self.state == YES) {
//        return;
//    }
//    //创建一个计时器
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playing) userInfo:nil repeats:YES];
//    
//    [self.musicPlayer play];
//    //设置为播放状态
//    self.state = YES;
//}
//- (void)playing{
//    //让代理操作UI 等数据
//    //当前播放时间 以秒为单位
//    CGFloat seconds = self.musicPlayer.currentTime.value/self.musicPlayer.currentTime.timescale;
//    
//    //让代理执行方法
//    if (self.playDelegate && [self.playDelegate respondsToSelector:@selector(playerPlayingWithProgress:)]) {
//        
//        [self.playDelegate playerPlayingWithProgress:seconds];
//    }
//}

#pragma mark 暂停
//- (void)pause{
//    [self.timer invalidate];
//    self.timer = nil;
//    
//    if (self.state == NO) {
//        return;
//    }
//    
//    [self.musicPlayer pause];
//    //设置播放状态为暂停
//    self.state = NO;
//}

#pragma mark 停止
- (void)stop
{
    
}

@end
