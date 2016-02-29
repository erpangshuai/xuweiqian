//
//  radioController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "radioController.h"
#import "radioModel.h"
#import "songListTableViewCell.h"
#import "RadioDetailViewController.h"

#define Url @"http://mobile.ximalaya.com/mobile/discovery/v1/rankingList/album?device=android&key=ranking%3Aalbum%3Aplayed%3A7%3A17&pageId=1&pageSize=40"

#define url1 @"http://mobile.ximalaya.com/mobile/discovery/v1/rankingList/album?device=android&key=ranking%3Aalbum%3Aplayed%3A7%3A17&pageId="
#define url2 @"&pageSize=40"

#define RankWidth [UIScreen mainScreen].bounds.size.width
#define RankHeight [UIScreen mainScreen].bounds.size.height
@interface radioController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *radioController;

//解析数据
@property(nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation radioController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downLoadGiftDataFinish:^{
        [self.radioController  reloadData];
    } withIndex:self.index];
    
    self.view.backgroundColor = [UIColor blueColor];
    self.radioController = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, RankWidth, RankHeight-116) style:UITableViewStylePlain];
    [self.view addSubview:self.radioController];
    
    self.radioController.delegate = self;
    self.radioController.dataSource = self;
    
    [self.radioController registerNib:[UINib nibWithNibName:@"songListTableViewCell" bundle:nil] forCellReuseIdentifier:@"main_cell"];
    // Do any additional setup after loading the view.
}

- (void)downLoadGiftDataFinish:(void(^)())result withIndex:(NSInteger)index{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *url3 = [NSString stringWithFormat:@"%@%ld%@", url1, index + 1, url2];
        NSURL *url4 = [NSURL URLWithString:url3];
        NSURLRequest *request = [NSURLRequest requestWithURL:url4];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *array =resultDict[@"list"];
            for (NSDictionary *dict in array) {
                radioModel *model = [[radioModel alloc] init];
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
    songListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"main_cell" forIndexPath:indexPath];
    radioModel *model = self.dataArray[indexPath.row];
    [cell setCellWithModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RadioDetailViewController *radio = [[RadioDetailViewController alloc]init];
    radioModel *model = self.dataArray[indexPath.row];
    radio.albumId = model.albumId;
    radio.position = [NSString stringWithFormat:@"%ld", indexPath.row];
    [self.navigationController pushViewController:radio animated:YES];
    
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
