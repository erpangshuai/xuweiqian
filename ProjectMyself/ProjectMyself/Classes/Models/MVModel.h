//
//  MVModel.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVModel : NSObject
//作者
@property(nonatomic, copy)NSString *artist_name;
//标题
@property(nonatomic, copy)NSString *title;
//图片
@property(nonatomic, copy)NSString *mv_cover;
//MV
@property(nonatomic, copy)NSString *url;

//下载时候需要用的进度
@property (nonatomic, assign)float progressValue;
//视频是否下载完成
@property(nonatomic, assign)BOOL isDownFinished;



@end
