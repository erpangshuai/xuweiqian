//
//  Datahandel.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "Datahandel.h"
static Datahandel *handler = nil;
@implementation Datahandel

+ (instancetype)shareInstance {
    if (nil == handler) {
        handler = [[Datahandel alloc] init];
    }
    return handler;
}
@end
