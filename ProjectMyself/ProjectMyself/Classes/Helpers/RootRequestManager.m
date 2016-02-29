//
//  RootRequestManager.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/30.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "RootRequestManager.h"
#import "Rootmodel.h"

static RootRequestManager *manager = nil;

@interface RootRequestManager ()

@property (nonatomic, strong)NSMutableArray *modelsArray;
@end
@implementation RootRequestManager

#pragma mark - 单例

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [RootRequestManager new];
    });
    return manager;
}
#pragma mark 懒加载
- (NSMutableArray *)modelsArray{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}

#pragma mark - 数据处理

#pragma mark 根据url请求数据 并进行回调
- (void)requestWithUrl:(NSString *)url didFinish:(void (^)())finish
{
    //开辟子线程请求数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSArray *dataArray = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:url]];
        
        //进行数据解析
        
        if (!dataArray) {
            return;
        }
        
        //遍历数组 取出字典
        for (NSDictionary *dict in dataArray) {
            
            //创建模型并赋值
            Rootmodel *model = [[Rootmodel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            
            //将模型存储进数组
            [self.modelsArray addObject:model];
        }
        //回到主线程 处理UI
        dispatch_async(dispatch_get_main_queue(), ^{
            //block 回调
            finish();
        });
        
    });
}

#pragma mark 返回数组个数
- (NSInteger)countofArray
{
    return self.modelsArray.count;
}

#pragma mark 根据下标返回模型
- (Rootmodel *)modelWithIndex:(NSInteger)index
{
    Rootmodel *model = self.modelsArray[index];
    return model;
}



@end
