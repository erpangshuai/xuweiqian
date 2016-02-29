//
//  CQ_NetTools.m
//  UIlesson17-NetWorking2
//
//  Created by lanou3g on 15/12/29.
//  Copyright © 2015年 徐未钱. All rights reserved.
//

#import "CQ_NetTools.h"

@implementation CQ_NetTools
+(void)solveDataWithUrl:(NSString *)StringUrl HttpMethod:(NSString *)method HttpBody:(NSString *)stringBody revokeBlock:(DateBlok)block{
    NSURL *url = [NSURL URLWithString:StringUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    //将所有的字母转换成大写
    NSString *SMethod = [method uppercaseString];
    if ([@"POST" isEqualToString:SMethod]) {
        [request setHTTPMethod:SMethod];
        NSData *data = [stringBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }else if ([@"GET" isEqualToString:SMethod]){
        
    }else{
        @throw [NSException exceptionWithName:@"CQ Param Error" reason:@"方法类型参数错误" userInfo:nil];
//        NSLog(@"方法类型数据参数错误");(第二种方法)
        return;
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        block(data);
    }];
}

+ (void)SessionDownloadWithUrl:(NSString *)stringUrl revokeBlock:(imageSolveblock)block{
    //创建url
    NSURL *url = [NSURL URLWithString:stringUrl];
    //创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    //创建回话
    NSURLSession *session = [NSURLSession sharedSession];
    //创建任务
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *imagedata = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:imagedata];
        //从子线程回到主线程进行界面更新
        dispatch_async(dispatch_get_main_queue(), ^{
            block(image);
        });
        
    }];
    //启动任务
    [task resume];
}


@end
