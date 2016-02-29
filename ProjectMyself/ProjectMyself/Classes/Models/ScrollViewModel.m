//
//  ScrollViewModel.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "ScrollViewModel.h"

@implementation ScrollViewModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}


@end
