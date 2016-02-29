//
//  RootRequestManager.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/30.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Rootmodel;

@interface RootRequestManager : NSObject
/**
 *  shareInstance 单例
 */
+(instancetype)shareInstance;

/**
 *@param NSString url 数据接口 didFinish 成功回调
 *@return Void
 **/

- (void)requestWithUrl:(NSString *)url didFinish:(void(^)())finish;

/**
 *@return NSInteger count 数组个数
 **/
- (NSInteger)countofArray;

/**
 *@param index 下标
 *@return model 歌曲模型
 **/
- (Rootmodel *)modelWithIndex:(NSInteger)index;


@end
