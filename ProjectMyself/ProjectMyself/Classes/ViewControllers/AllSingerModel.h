//
//  AllSingerModel.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllSingerModel : NSObject
@property(nonatomic,copy)NSString * alias;
@property(nonatomic,copy)NSString * artist_logo;
@property(nonatomic,copy)NSString * artist_name;
@property(nonatomic,strong)NSNumber * count_likes;
@property(nonatomic,assign)BOOL is_musician;
@property(nonatomic,copy)NSString *pinyin;
@end
