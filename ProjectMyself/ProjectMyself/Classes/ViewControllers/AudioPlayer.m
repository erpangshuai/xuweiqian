//
//  AudioPlayer.m
//  Gegeda_music_MY
//
//  
//

#import <AVFoundation/AVFoundation.h>
#import "AudioPlayer.h"

@interface AudioPlayer ()
{
    BOOL _isPrepare;
    BOOL _isPlaying;
}

@property(nonatomic,strong)AVPlayer *player;

@end



@implementation AudioPlayer

-(void)dealloc
{
    // 移除通知中心
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

-(instancetype)init
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playEndAction:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

+(AudioPlayer*)sharedInstance
{
    static AudioPlayer *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[AudioPlayer alloc]init];
    });
    return player;
}

//// 根据时间 获取下标  歌词哪儿
//-(NSInteger)indexWithTime:(float)time
//{
//    for (int i = 0 ;  i < self.allLiricArray.count ; i++)
//    {
//        // 取出模型
//        LiricModel1 *model = self.allLiricArray[i];
//        if( model.time1 > time )
//        {
//            //   NSLog(@"****************%f", model.time1);
//            self.index =  ((i - 1 > 0) ? (i - 1) : 0);
//            //
//            //           self.index = i;
//            break;
//        }
//    }
//    
//    return self.index;
//    
//    
//}

-(void)prepareWithURL:(NSString*)url
{
    [self pause];
    // 创建一个 item
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:url]];
    // 释放观察者
    if (self.player.currentItem)
    {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
    
    // 添加观察者
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.player replaceCurrentItemWithPlayerItem:item];
//    [self play];
}

-(void)play
{
    if (!_isPrepare)
    {
        return;
    }
// 播放
    [self.player play];
    _isPlaying = YES;
    if (self.timer)
    {
        return;    // 判断定时器是否存在
    }
    
    // 在此处 初始化定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
}

// 暂停
-(void)pause
{
    if (!_isPlaying)
    {
        return;
    }
    [self.player pause];
    _isPlaying = NO;
    // 销毁定时器
    [self.timer invalidate];
    self.timer = nil;
    // 用于暂停时 图片停止旋转
}

// 停止
-(void)stop
{
    if (!_isPlaying)
    {
        return;
    }
    // 先暂停 在停止 再把时间值为零
    [self.player pause];
    // 把时间设置到 0 秒
    [self.player seekToTime:CMTimeMake(0, self.player.currentTime.timescale)];   // 播放频率
    
}

// 音量
-(void)setVolumn:(float)volumn
{
    self.player.volume = volumn;
}

// 从指定时间开始播放
-(void)seekToTime:(float)time
{
    // 先暂停
    [self pause];
    
    // 设置开始播放的时间
    [self.player seekToTime:CMTimeMakeWithSeconds(time, self.player.currentTime.timescale)completionHandler:^(BOOL finished) {
        // 开始播放
        if (finished)
        {
            [self play];
        }

    }];

}


// 定时器 方法
-(void)timerAction:(NSTimer*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(playWithPlayer:withProgress:)])
    {
        float progress = self.player.currentTime.value / self.player.currentTime.timescale;
        
        [self.delegate playWithPlayer:self withProgress:progress];
    }
    
}

// 通知中心的方法
-(void)playEndAction:(NSNotification*)sender
{
    // 播放完成的时候 判断代理是否存在
    if (self.delegate && [self.delegate respondsToSelector:@selector(playEndFinish:)])
    {
        [self.delegate playEndFinish:self];    // 最后要 移除通知中心
    
    // 移除在 dealloc 中实现
    }
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
//    NSLog(@"%@", keyPath);
    
    if ([keyPath isEqualToString:@"status"])
    {
        AVPlayerStatus status = [change[@"new"]integerValue];
        
        switch (status) {
            case AVPlayerStatusFailed:
            {
//                NSLog(@"失败");
                break;
                
            }
            case AVPlayerStatusReadyToPlay:
            {
//                NSLog(@"准备好播放");
                _isPrepare = YES;
                // 播放
                [self play];
                break;
            }
            case AVPlayerStatusUnknown:
            {
//                NSLog(@"未知");
                break;
            }
                
            default:
                break;
        }
        
    }
 
    
    
}


-(AVPlayer *)player
{
    if (!_player)
    {
        _player = [[AVPlayer alloc]init];
        self.player.volume = 1.0;
    }
    return _player;
}


@end
