//
//  sectionModel.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sectionModel : NSObject

@property(nonatomic,copy)NSString *calcDimension;
@property(nonatomic,copy)NSString *contentType;
@property(nonatomic,copy)NSString *hasMore;
@property(nonatomic,strong)NSArray *list;
@property(nonatomic,copy)NSString *moduleType;
@property(nonatomic,copy)NSString *tagName;
@property(nonatomic,copy)NSString *title;

@end
