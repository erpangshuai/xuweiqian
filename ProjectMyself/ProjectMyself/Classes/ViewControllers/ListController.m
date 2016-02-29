//
//  ListController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 徐未钱. All rights reserved.
//
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define top50URL   @"http://mobile.ximalaya.com/mobile/discovery/v1/rankingList/album?device=android&key=ranking%3Aalbum%3Aplayed%3A1%3A2&pageId="

#define top50URL1  @"&pageSize=40"

#define hotURL @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="

#define hotURL1 @"&pageSize=20&status=0&tagName="


#define specialSelectedURL  @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="

#define specialSelectedURL1 @"&pageSize=20&status=0&tagName=%E7%B2%BE%E9%80%89%7C%E6%AD%8C%E5%8D%95"


#define secondSingURL  @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="

#define secondSingURL1 @"&pageSize=20&status=0&tagName=%E7%BF%BB%E5%94%B1%7C%E7%BF%BB%E5%A5%8F"


#define MajorHostURL  @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="

#define MajorHostURL1 @"&pageSize=20&status=0&tagName=%E4%B8%BB%E6%92%AD%7C%E8%8A%82%E7%9B%AE"


#define authrityURL  @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="

#define authrityURL1 @"&pageSize=20&status=0&tagName=%E6%A6%9C%E5%8D%95%7C%E6%8E%92%E8%A1%8C"


#define bigStarURL  @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="

#define bigStarURL1 @"&pageSize=20&status=0&tagName=%E8%89%BA%E4%BA%BA%7C%E6%98%8E%E6%98%9F"


#define knowAgeURL  @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="

#define knowAgeURL1 @"&pageSize=20&status=0&tagName=%E6%80%80%E6%97%A7%7C%E7%BB%8F%E5%85%B8"


#define heightBigTopURL  @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="

#define heightBigTopURL1 @"&pageSize=20&status=0&tagName=%E6%AC%A7%E7%BE%8E%7C%E5%85%B6%E4%BB%96"


#define inEarURL  @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId=1&pageSize=20&status=0&tagName=%E7%9D%A1%E5%89%8D.%E5%82%AC%E7%9C%A0"

#define inEarURL1 @"&pageSize=20&status=0&tagName=%E7%9D%A1%E5%89%8D.%E5%82%AC%E7%9C%A0"


#define threeDURL  @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="

#define threeDURL1 @"&pageSize=20&status=0&tagName=3D%E5%A5%87%E5%A6%99%E4%BD%93%E9%AA%8C%E9%A6%86"


#import "ListController.h"
#import "recommendCell.h"
#import "listModel.h"
#import "UIImageView+WebCache.h"
#import "CQ_NetTools.h"
#import "RadioDetailViewController.h"
@interface ListController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)UITableView *hotTableview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hotTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight- 60) style:UITableViewStylePlain];
    self.hotTableview.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.hotTableview];
    
    self.hotTableview.dataSource = self;
    self.hotTableview.delegate = self;
    
    [self.hotTableview registerClass:[recommendCell class] forCellReuseIdentifier:@"flag"];
    self.dataArray = [NSMutableArray array];
    
     [self loadDataFromNetWorkAsyn];
    
    
    // Do any additional setup after loading the view.
}

- (void)loadDataFromNetWorkAsyn{
    NSURL *url = [[NSURL alloc]init];
    
    if (self.tagIndex == 0) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld%@", top50URL, self.index1, top50URL1]];
        self.title = @"音乐榜TOP50";
    }
    if (self.index == 1) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld%@",hotURL,self.index1,hotURL1]];
        self.title = @"最火最热最潮";
    }else if (self.index == 2) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld%@",specialSelectedURL,self.index1,specialSelectedURL1]];
        self.title = @"精选歌单";
    }else if (self.index == 3) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@,%ld%@",secondSingURL,self.index1,secondSingURL1]];
        self.title = @"经典翻唱";
    }else if (self.index == 4) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld%@",MajorHostURL,self.index1,MajorHostURL1]];
        self.title = @"人气主播";
    }else if (self.index == 5) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld%@",authrityURL,self.index1,authrityURL1]];
        self.title = @"权威榜单";
    }else if (self.index == 6){
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld%@",bigStarURL,self.index1,bigStarURL1]];
        self.title = @"大明星大听头";
    }else if (self.index == 7)
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld%@",knowAgeURL,self.index1,knowAgeURL1]];
        self.title = @"暴露你的年龄";
    }
    else if (self.index == 8)
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld%@",heightBigTopURL,self.index1,heightBigTopURL1]];
        self.title = @"欧美歌曲精选";
    }
    else if (self.index == 9)
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld%@",inEarURL,self.index1,inEarURL1]];
        self.title = @"周末听歌";
    }
    else if(self.index == 10)
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld%@",threeDURL,self.index1,threeDURL1]];
        self.title = @"3D奇妙体验馆";
    }

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSDictionary *request = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *activityArray = request[@"list"];
        for (NSDictionary *dict in activityArray) {
            listModel *model = [[listModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        [self.hotTableview reloadData];
        self.index1 = (self.hotTableview.contentOffset.y - 1456)/2000;
//        NSLog(@"%f", self.hotTableview.contentOffset.y);
        self.index1 = self.index1 +1;
        
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    recommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flag" forIndexPath:indexPath];
    listModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.introLabel.text = model.intro;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.albumCoverUrl290]];
    cell.userLabel.text = [NSString stringWithFormat:@"%@", model.playsCounts];
    cell.setLabel.text = [NSString stringWithFormat:@"%@集", model.tracksCounts];
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RadioDetailViewController *radioVC = [[RadioDetailViewController alloc]init];
    listModel *model = self.dataArray[indexPath.row];
    radioVC.albumId = [NSString stringWithFormat:@"%@", model.albumId];
    radioVC.position = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    [self.navigationController pushViewController:radioVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
