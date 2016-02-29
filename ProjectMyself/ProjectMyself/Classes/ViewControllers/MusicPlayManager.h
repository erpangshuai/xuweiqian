//
//  MusicPlayManager.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "detailTableViewModel.h"
@class playMusicModel;

/**
 *  播放器协议
 */
@protocol AVplayerDelegate <NSObject>
/**
 *播放过程中一直执行
 *@param 播放进度
 **/
- (void)playerPlayingWithProgress:(float)progress;
/**
 *  播放结束执行
 */
- (void)playEndToTime;

@end

@interface MusicPlayManager : NSObject

@property (nonatomic, assign)id<AVplayerDelegate>playDelegate;
//记录播放状态
//@property (nonatomic, assign)BOOL state;
//播放器声音
@property (nonatomic, assign)float Volumn;
/**
 *  单例
 */
+ (instancetype)shareInstance;

-(void)downLoadDataFinished:(void(^)())result2 withPlayModel:(detailTableViewModel*)model;
/**
 *  播放
 */
//- (void)play;
///**
// *  暂停
// */
//- (void)pause;
///**
// *  停止
// */
//-(void)stop;


/**
 *@param 从指定时间进行播放
 **/
//- (void)seekTimeToPlay:(float)Value;

@property(nonatomic,strong)NSArray *playMusicArray;
@property(nonatomic,strong)playMusicModel *model;

@end
