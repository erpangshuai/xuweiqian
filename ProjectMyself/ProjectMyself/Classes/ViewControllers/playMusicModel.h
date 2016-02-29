//
//  playMusicModel.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface playMusicModel : NSObject

@property(nonatomic,copy)NSString *activityId;
@property(nonatomic,copy)NSString *albumId;
@property(nonatomic,copy)NSString *albumImage;
@property(nonatomic,copy)NSString *albumTitle;
@property(nonatomic,copy)NSString *categoryId;
@property(nonatomic,copy)NSString *categoryName;
@property(nonatomic,copy)NSString *comments;
@property(nonatomic,copy)NSString *coverLarge;
@property(nonatomic,copy)NSString *coverMiddle;
@property(nonatomic,copy)NSString *coverSmall;
@property(nonatomic,copy)NSString *createdAt;
@property(nonatomic,copy)NSString *downloadAacSize;
@property(nonatomic,copy)NSString *downloadAacUrl;
@property(nonatomic,copy)NSString *downloadSize;
@property(nonatomic,copy)NSString *downloadUrl;
@property(nonatomic,copy)NSString *duration;
@property(nonatomic,strong)NSArray *images;
@property(nonatomic,copy)NSString *intro;
@property(nonatomic,copy)NSString *isLike;
@property(nonatomic,copy)NSString *isPublic;
@property(nonatomic,copy)NSString *isRelay;
@property(nonatomic,copy)NSString *likes;
@property(nonatomic,copy)NSString *lyric;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,copy)NSString *playPathAacv164;
@property(nonatomic,copy)NSString *playPathAacv224;
@property(nonatomic,copy)NSString *playtimes;
@property(nonatomic,copy)NSString *playUrl32;
@property(nonatomic,copy)NSString *playUrl64;
@property(nonatomic,copy)NSString *processState;
@property(nonatomic,copy)NSString *refSmallLogo;
@property(nonatomic,copy)NSString *ret;
@property(nonatomic,copy)NSString *richIntro;
@property(nonatomic,copy)NSString *shares;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *tags;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray *trackBlocks;
@property(nonatomic,copy)NSString *trackId;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,strong)NSDictionary *userInfo;
@property(nonatomic,copy)NSString *userSource;

@end
