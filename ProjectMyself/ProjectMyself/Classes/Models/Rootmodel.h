//
//  Rootmodel.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/30.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rootmodel : NSObject
//MP3地址
@property(nonatomic, copy) NSString *mp3Url;
//歌曲id
@property(nonatomic, copy) NSString *ID;
//歌名
@property(nonatomic, copy) NSString *name;
//图片地址
@property(nonatomic, copy) NSString *picUrl;
//缩略图地址
@property(nonatomic, copy) NSString *blurPicUrl;
//专辑
@property(nonatomic, copy) NSString *album;
//歌手
@property(nonatomic, copy) NSString *singer;
//时长
@property(nonatomic, copy) NSString *duration;
//作者名字
@property(nonatomic, copy) NSString *artists_name;
//歌词
@property(nonatomic, copy) NSString *lyric;

@end
