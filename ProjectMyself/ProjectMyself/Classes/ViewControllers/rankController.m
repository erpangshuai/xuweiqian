//
//  rankController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "rankController.h"
#import "recommendCell.h"
#import "recommendHelper.h"
#import "recommendModel.h"
#import "UIImageView+WebCache.h"
#import "RadioDetailViewController.h"

#define RankWidth [UIScreen mainScreen].bounds.size.width
#define RankHeight [UIScreen mainScreen].bounds.size.height
@interface rankController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong)UITableView *bigTableView;

@end

@implementation rankController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[recommendHelper sharedInstancetype]downLoadrankDataFinished:^{
        [self.bigTableView reloadData];
    } withIndex:self.index];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    
    self.bigTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, RankWidth, RankHeight - 116) style:UITableViewStylePlain];
    [self.view addSubview:self.bigTableView];
    self.bigTableView.delegate = self;
    self.bigTableView.dataSource = self;
    
    [self.bigTableView registerClass:[recommendCell class] forCellReuseIdentifier:@"flag"];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)headerHeightDidClicked{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新表格
        if ([recommendHelper sharedInstancetype].rankArray == nil) {
            [self.bigTableView reloadData];
        }
         // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [self.bigTableView ]
    });
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [recommendHelper sharedInstancetype].rankArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    recommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flag" forIndexPath:indexPath];
    recommendModel *model = [recommendHelper sharedInstancetype].rankArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLabel.text = model.title;
    
    cell.introLabel.text = model.intro;
    
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.albumCoverUrl290]];
    
    cell.userLabel.text = [NSString stringWithFormat:@"%@", model.playsCounts];
    
    cell.setLabel.text = [NSString stringWithFormat:@"%@集", model.tracksCounts];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    recommendModel *model = [recommendHelper sharedInstancetype].rankArray[indexPath.row];
    RadioDetailViewController *radioVC = [[RadioDetailViewController alloc]init];
    [self.navigationController pushViewController:radioVC animated:YES];
    radioVC.albumId = model.albumId;
    radioVC.position = [NSString stringWithFormat:@"%ld",indexPath.row];
//
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
