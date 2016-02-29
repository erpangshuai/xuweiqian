//
//  recommendHelper.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface recommendHelper : NSObject
+(recommendHelper*)sharedInstancetype;

@property(nonatomic,strong)NSArray *recommendArray;
@property(nonatomic,strong)NSArray *topArray;
@property(nonatomic,strong)NSArray *scrollArray;
// 存tableviewcell 头部 label 的数组
@property(nonatomic,strong)NSMutableArray *sectionArray;
//存3Dmodel
@property(nonatomic,strong)NSArray *threeDArray;
//存电影原声
@property(nonatomic,strong)NSArray *movieArray;
//存翻唱
@property(nonatomic,strong)NSArray *fanchangArray;


@property(nonatomic,strong)NSArray *listDataArray;

// // // // // 排行的属性
@property(nonatomic,strong)NSArray *rankArray;


-(void)downLoadDataFinished:(void(^)())result2;

-(void)downLoadrankDataFinished:(void(^)())result3 withIndex:(NSInteger)index;
-(void)downLoad3DDataFinished:(void(^)())result4 withIndex:(NSInteger)index;
-(void)downLoadMovieDataFinished:(void(^)())result4 withIndex:(NSInteger)index;
-(void)downLoadfanchangDataFinished:(void(^)())result4 withIndex:(NSInteger)index;

@end
