//
//  songListModel.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface songListModel : NSObject
@property(nonatomic, copy)NSString *title; //标题
@property(nonatomic, copy)NSString *intro;//分类
@property(nonatomic, copy)NSString *albumCoverUrl290; //图片
@property(nonatomic, copy)NSString *tracks;  //集数
@property(nonatomic, copy)NSString *playsCounts;  //听众
@property(nonatomic,copy)NSString *albumId;


@end
