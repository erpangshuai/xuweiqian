//
//  TopModel.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopModel : NSObject
@property(nonatomic,copy)NSString *calcPeriod;
@property(nonatomic,copy)NSString *categoryId;
@property(nonatomic,copy)NSString *contentType;
@property(nonatomic,copy)NSString *coverPath;
@property(nonatomic,copy)NSString *firstId;
@property(nonatomic,strong)NSArray *firstKResults;
@property(nonatomic,copy)NSString *firstTitle;
@property(nonatomic,copy)NSString *key;
@property(nonatomic,copy)NSString *orderNum;
@property(nonatomic,copy)NSString *period;
@property(nonatomic,copy)NSString *rankingRule;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *top;

@end
