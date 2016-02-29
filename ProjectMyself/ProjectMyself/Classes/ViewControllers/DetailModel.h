//
//  DetailModel.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DetailModel : NSObject

@property(nonatomic, copy)NSString *coverLarge;   //大图片
@property(nonatomic, copy)NSString *avatarPath;   //小图片
@property(nonatomic, copy)NSString *nickname;   //类型(歌单精选集)
@property(nonatomic, copy)NSString *tags;  //小类型
//@property(nonatomic, copy)NSString *title;  //大标题
@property(nonatomic, copy)NSString *intro;   //简介

@property(nonatomic, assign)NSInteger tracks;  //集数

@end
