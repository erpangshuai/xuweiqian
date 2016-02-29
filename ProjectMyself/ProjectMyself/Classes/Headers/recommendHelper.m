//
//  recommendHelper.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "recommendHelper.h"
#import "recommendModel.h"
#import "sectionModel.h"
#import "TopModel.h"
#import "ScrollViewModel.h"

#define RecommendURL @"http://mobile.ximalaya.com/mobile/discovery/v2/category/recommends?categoryId=2&contentType=album&device=android&scale=2&version=4.3.20.2"

#define RankURL @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId=1&pageSize=20&status=0&tagName=%E6%A6%9C%E5%8D%95%7C%E6%8E%92%E8%A1%8C"

#define RankURL1 @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="
#define RankURL2 @"&pageSize=20&status=0&tagName=%E6%A6%9C%E5%8D%95%7C%E6%8E%92%E8%A1%8C"

#define ThreeDURL1 @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="
#define ThreeDURL2 @"&pageSize=20&status=0&tagName=3D%E5%A5%87%E5%A6%99%E4%BD%93%E9%AA%8C%E9%A6%86"

#define MovieURL1 @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="
#define MovieURL2 @"&pageSize=20&status=0&tagName=%E7%94%B5%E5%BD%B1%7C%E5%8E%9F%E5%A3%B0"

#define FanchangURL1 @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="

#define FanchangURL2 @"&pageSize=20&status=0&tagName=%E7%BF%BB%E5%94%B1%7C%E7%BF%BB%E5%A5%8F"

@interface recommendHelper ()
@property(nonatomic,strong)NSMutableArray *recommendDataArray;
@property(nonatomic,strong)NSMutableArray *scrollViewDataArray;
@property(nonatomic,strong)NSMutableArray *topDataArray;
@property(nonatomic,strong)NSMutableArray *threeDDataArray;
@property(nonatomic,strong)NSMutableArray *movieDataArray;
@property(nonatomic,strong)NSMutableArray *fanchangDataArray;


// 排行的属性
@property(nonatomic,strong)NSMutableArray *rankDataArray;

@end

static recommendHelper *beautiful = nil;
@implementation recommendHelper

+(recommendHelper *)sharedInstancetype{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        beautiful = [recommendHelper new];
    });
    return beautiful;
}

- (void)downLoadDataFinished:(void (^)())result2
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURLSession *session = [NSURLSession sharedSession];
        //拿到第一个url
        NSURL *url = [NSURL URLWithString:RecommendURL];
        
        NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *recommendDict = result[@"categoryContents"];
            NSMutableArray *listArray =recommendDict[@"list"];
            
            //scrollView的数据
            NSDictionary *zeroDict = listArray.firstObject;
            
            NSArray *smallListArray = zeroDict[@"list"];
            TopModel *model = [[TopModel alloc]init];
            [model setValuesForKeysWithDictionary:smallListArray.firstObject];
            [self.topDataArray addObject:model];
            [listArray removeObjectAtIndex:0];
//            NSLog(@"数组元素个数 = %ld", listArray.count);
            self.sectionArray = [NSMutableArray array];
            for (NSDictionary *dict in listArray) {
                sectionModel *model= [[sectionModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.sectionArray addObject:model];
                
                
                for (NSDictionary *listDict in model.list) {
                    recommendModel *model = [[recommendModel alloc]init];
                    [model setValuesForKeysWithDictionary:listDict];
                    [self.recommendDataArray addObject:model];
                }
                
            }
          
            NSDictionary *scrollViewDict = result[@"focusImages"];
            NSArray *scrollArray = scrollViewDict[@"list"];
            
            for (NSDictionary *dict in scrollArray) {
                ScrollViewModel *model = [[ScrollViewModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.scrollViewDataArray addObject:model];
            }
        
            
            dispatch_async(dispatch_get_main_queue(), ^{
                result2();
            });
            
        }];
        
        [task resume];
    });
    
}
- (void)downLoadrankDataFinished:(void (^)())result3 withIndex:(NSInteger)index{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        //   NSLog(@"=========%ld",index);
        
        
        NSString *url1 = [NSString stringWithFormat:@"%@%ld%@",RankURL1,index + 1,RankURL2];
        //  NSLog(@"网址变变变 == %@",url1);
        
        
        // 拿到一个 url
        NSURL *url = [NSURL URLWithString:url1];
        
        NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *rankArray = result[@"list"];
            //    NSLog(@"=-=-=-=-=-=-=-%@",rankArray);
            for (NSDictionary *dict in rankArray)
            {
                recommendModel *model = [[recommendModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                
                [self.rankDataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                result3();
                
            });
        }];
        
        [task resume];
    });
    

}
-(void)downLoad3DDataFinished:(void(^)())result4 withIndex:(NSInteger)index
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        //   NSLog(@"=========%ld",index);
        
        
        NSString *url1 = [NSString stringWithFormat:@"%@%ld%@",ThreeDURL1,index + 1,ThreeDURL2];
//        NSLog(@"网址变变变 == %@",url1);
        
        
        // 拿到一个 url
        NSURL *url = [NSURL URLWithString:url1];
        
        NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *rankArray = result[@"list"];
            //    NSLog(@"=-=-=-=-=-=-=-%@",rankArray);
            for (NSDictionary *dict in rankArray)
            {
                recommendModel *model = [[recommendModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                
                [self.threeDDataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                result4();
                
            });
        }];
        
        [task resume];
    });
    
    
}

-(void)downLoadMovieDataFinished:(void(^)())result4 withIndex:(NSInteger)index
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        //   NSLog(@"=========%ld",index);
        
        
        NSString *url1 = [NSString stringWithFormat:@"%@%ld%@",MovieURL1,index + 1,MovieURL2];
//        NSLog(@"网址变变变 == %@",url1);
        
        
        // 拿到一个 url
        NSURL *url = [NSURL URLWithString:url1];
        
        NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *rankArray = result[@"list"];
            //    NSLog(@"=-=-=-=-=-=-=-%@",rankArray);
            for (NSDictionary *dict in rankArray)
            {
                recommendModel *model = [[recommendModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                
                [self.movieDataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                result4();
                
            });
        }];
        
        [task resume];
    });
}


-(void)downLoadfanchangDataFinished:(void(^)())result4 withIndex:(NSInteger)index
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        //   NSLog(@"=========%ld",index);
        
        
        NSString *url1 = [NSString stringWithFormat:@"%@%ld%@",FanchangURL1,index + 1,FanchangURL2];
//        NSLog(@"网址变变变 == %@",url1);
        
        
        // 拿到一个 url
        NSURL *url = [NSURL URLWithString:url1];
        
        NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *rankArray = result[@"list"];
            //    NSLog(@"=-=-=-=-=-=-=-%@",rankArray);
            for (NSDictionary *dict in rankArray)
            {
                recommendModel *model = [[recommendModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                
                [self.fanchangDataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                result4();
                
            });
        }];
        
        [task resume];
    });
}
-(NSMutableArray *)recommendDataArray
{
    if (!_recommendDataArray)
    {
        _recommendDataArray = [NSMutableArray array];
    }
    return _recommendDataArray;
}

-(NSMutableArray *)scrollViewDataArray
{
    if (!_scrollViewDataArray)
    {
        _scrollViewDataArray = [NSMutableArray array];
    }
    return _scrollViewDataArray;
}

-(NSMutableArray *)topDataArray
{
    if (!_topDataArray)
    {
        _topDataArray = [NSMutableArray array];
    }
    return _topDataArray;
}

-(NSArray *)recommendArray
{
    return [self.recommendDataArray copy];
}

-(NSArray *)scrollArray
{
    
    return [self.scrollViewDataArray copy];
    
}

-(NSArray *)topArray
{
    return [self.topDataArray copy];
}

-(NSMutableArray *)rankDataArray
{
    if (!_rankDataArray)
    {
        _rankDataArray = [NSMutableArray array];
    }
    return _rankDataArray;
}
-(NSMutableArray *)threeDDataArray
{
    if (!_threeDDataArray)
    {
        _threeDDataArray = [NSMutableArray array];
    }
    return _threeDDataArray;
}
-(NSMutableArray *)fanchangDataArray
{
    if (!_fanchangDataArray)
    {
        _fanchangDataArray = [NSMutableArray array];
    }
    return _fanchangDataArray;
}
-(NSMutableArray *)movieDataArray
{
    if (!_movieDataArray)
    {
        _movieDataArray = [NSMutableArray array];
    }
    return _movieDataArray;
}
-(NSArray*)movieArray
{
    return [self.movieDataArray copy];
}
-(NSArray*)fanchangArray
{
    return [self.fanchangDataArray copy];
}
-(NSArray*)rankArray
{
    return [self.rankDataArray copy];
}

-(NSArray*)threeDArray
{
    return [self.threeDDataArray copy];
}







@end
