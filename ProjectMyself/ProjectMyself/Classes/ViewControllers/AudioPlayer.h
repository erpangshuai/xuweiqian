//
//  AudioPlayer.h
//  Gegeda_music_MY
//
// ghts reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@class AudioPlayer;

@protocol AudioPlayDelegate <NSObject>

@optional

// 播放过程中一直执行 记录时间 返回给 控制器的进度条
-(void)playWithPlayer:(AudioPlayer*)player withProgress:(float)progress;

// 播放结束
-(void)playEndFinish:(AudioPlayer*)player;

@end

@interface AudioPlayer : NSObject

// 声明 协议属性
@property(nonatomic,assign)id<AudioPlayDelegate>delegate;

+(AudioPlayer*)sharedInstance;

// 声明方法
@property(nonatomic,assign)BOOL isPlaying;
@property(nonatomic,assign)float volumn;
@property(nonatomic,strong)NSTimer *timer;

/*
 
 准备 播放的网址
 
 */




-(void)prepareWithURL:(NSString*)url;

// 播放
-(void)play;

// 暂停
-(void)pause;

// 停止
-(void)stop;

// 从指定时间开始播放
-(void)seekToTime:(float)time;


@end
