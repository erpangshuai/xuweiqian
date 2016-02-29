//
//  ThreeDViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "ThreeDViewController.h"
#import "recommendCell.h"
#import "recommendHelper.h"
#import "recommendModel.h"
#import "UIImageView+WebCache.h"
#import "RadioDetailViewController.h"

#define RankWidth [UIScreen mainScreen].bounds.size.width
#define RankHeight [UIScreen mainScreen].bounds.size.height

@interface ThreeDViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)UITableView *bigTableView;

@end

@implementation ThreeDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[recommendHelper sharedInstancetype] downLoad3DDataFinished:^{
        [self.bigTableView reloadData];
    } withIndex:self.index];

    
    self.view.backgroundColor = [UIColor colorWithRed:255.0/255 green:222.0/255 blue:249.0/255 alpha:1.0];
    
    self.bigTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, RankWidth, RankHeight-116) style:UITableViewStylePlain];
    [self.view addSubview:self.bigTableView];
    self.bigTableView.dataSource = self;
    self.bigTableView.delegate = self;
    
    [self.bigTableView registerClass:[recommendCell class] forCellReuseIdentifier:@"flag"];
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [recommendHelper sharedInstancetype].threeDArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    recommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flag" forIndexPath:indexPath];
    
    recommendModel *model = [recommendHelper sharedInstancetype].threeDArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.titleLabel.text = model.title;
    cell.introLabel.text = model.intro;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.albumCoverUrl290]];
    
    float my = [model.playsCounts floatValue];
    
    if (my >= 10000) {
        my = my /10000 ;
        cell.userLabel.text = [NSString stringWithFormat:@"%.1lf万",my];
    }else{
        cell.userLabel.text = [NSString stringWithFormat:@"%@",model.playsCounts];
    }
    

    cell.setLabel.text = [NSString stringWithFormat:@"%@集", model.tracksCounts];
    if ([cell.userLabel.text isEqualToString:@"0"]) {
        cell.userImage.hidden = YES;
        cell.userLabel.text = @"";
        cell.setImage.frame = CGRectMake(95, 78, 10, 10);
        cell.setLabel.frame = CGRectMake(112, 75, 65, 15);
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    recommendModel *model = [recommendHelper sharedInstancetype].threeDArray[indexPath.row];
    RadioDetailViewController *radio = [[RadioDetailViewController alloc] init];
    [self.navigationController pushViewController:radio animated:YES];
    
    radio.albumId = model.albumId;
    radio.position = [NSString stringWithFormat:@"%ld",indexPath.row];

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
