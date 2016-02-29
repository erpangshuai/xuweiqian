//
//  Rootmodel.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/30.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "Rootmodel.h"

@implementation Rootmodel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
