//
//  PlayMusicController.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailTableViewModel.h"
#import "playMusicModel.h"
@interface PlayMusicController : UIViewController
@property(nonatomic,strong)detailTableViewModel *receiveModel;
@property(nonatomic,strong)playMusicModel *reModel;
@property(nonatomic,strong)NSArray *dataArray3;
@property(nonatomic,assign)NSInteger index;
@end
