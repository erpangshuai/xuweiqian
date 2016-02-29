//
//  songListController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "songListController.h"
#import "songListTableViewCell.h"
#import "songListModel.h"
#import "RadioDetailViewController.h"

#define RankWidth [UIScreen mainScreen].bounds.size.width
#define RankHeight [UIScreen mainScreen].bounds.size.height
#define Url @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId=1&pageSize=20&status=0&tagName=%E7%B2%BE%E9%80%89%7C%E6%AD%8C%E5%8D%95"

#define url1 @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=android&pageId="
#define url2 @"&pageSize=20&status=0&tagName=%E7%B2%BE%E9%80%89%7C%E6%AD%8C%E5%8D%95"
@interface songListController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *songListTableView;

//数据解析
@property(nonatomic, strong)NSMutableArray *dataArray;

//下拉刷新
@property (nonatomic, strong)UIRefreshControl *control;
@end

@implementation songListController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self downLoadGiftDataFinish:^{
        [self.songListTableView reloadData];
    } withIndex:self.index];
    
    self.songListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, RankWidth, RankHeight-116) style:UITableViewStylePlain];
    [self.view addSubview:self.songListTableView];

    self.songListTableView.dataSource = self;
    self.songListTableView.delegate = self;

    [self.songListTableView registerNib:[UINib nibWithNibName:@"songListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //    刷新
    self.control = [[UIRefreshControl alloc]init];
    _control.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    //菊花颜色
    self.control.tintColor = [UIColor  colorWithRed:1.000 green:0.046 blue:0.039 alpha:1.000];
    [self.control addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.songListTableView addSubview:self.control];

    // Do any additional setup after loading the view.
}
- (void)refresh{
    //过多久执行方法
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"数据刷新中，上次更新日期 %@",
                             [formatter stringFromDate:[NSDate date]]];
    self.control.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:1.5];
    
}

- (void)refreshData{
    
    [self downLoadGiftDataFinish:^{
        [self.songListTableView reloadData];
        self.index = (self.songListTableView.contentOffset.y - 1515) / 2000 ;
        
        self.index = self.index + 1;

    } withIndex:self.index];
    [self.control endRefreshing];
}


- (void)downLoadGiftDataFinish:(void(^)())result withIndex:(NSInteger)index{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *url3 = [NSString stringWithFormat:@"%@%ld%@", url1,index+1,url2];
        NSURL *url4 = [NSURL URLWithString:url3];
        NSURLRequest *request = [NSURLRequest requestWithURL:url4];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *array = resultDict[@"list"];
            
            for (NSDictionary *dict in array) {
                songListModel *model = [[songListModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                result();
            });
        }];
    });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    songListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    songListModel *model = self.dataArray[indexPath.row];
    [cell setCellDataWithModel:model];
//    NSLog(@"%@", model);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    songListModel *model = self.dataArray[indexPath.row];
    
    RadioDetailViewController *radio = [[RadioDetailViewController alloc]init];
    [self.navigationController pushViewController:radio animated:YES];
    
    radio.albumId = model.albumId;
    radio.position = [NSString stringWithFormat:@"%ld", indexPath.row];
    
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
