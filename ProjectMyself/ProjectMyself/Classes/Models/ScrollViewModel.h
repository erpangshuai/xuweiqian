//
//  ScrollViewModel.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollViewModel : NSObject
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,assign)BOOL *is_External_url;
@property(nonatomic,assign)BOOL *isShare;
@property(nonatomic,copy)NSString *longTitle;
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *shortTitle;
@property(nonatomic,copy)NSString *trackId;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *uid;

@end
