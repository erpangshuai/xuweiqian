//
//  MovieViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "MovieViewController.h"
#define RankWidth [UIScreen mainScreen].bounds.size.width
#define RankHeight [UIScreen mainScreen].bounds.size.height
#import "UIImageView+WebCache.h"
#import "recommendHelper.h"
#import "recommendModel.h"
#import "rankController.h"
#import "recommendCell.h"
#import "songListModel.h"
#import "RadioDetailViewController.h"

@interface MovieViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)UITableView *bigTableView;@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[recommendHelper sharedInstancetype]downLoadMovieDataFinished:^{
        [self.bigTableView reloadData];
    } withIndex:self.index];
    
   
    self.bigTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, RankWidth, RankHeight - 116) style:UITableViewStylePlain];
    [self.view addSubview:self.bigTableView];
    self.bigTableView.delegate = self;
    self.bigTableView.dataSource = self;
    
    [self.bigTableView registerClass:[recommendCell class] forCellReuseIdentifier:@"flag"];
    
    
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recommendHelper sharedInstancetype].movieArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    recommendModel *model = [recommendHelper sharedInstancetype].movieArray[indexPath.row];
    
    recommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flag" forIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLabel.text = model.title;
    cell.introLabel.text = model.intro;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.albumCoverUrl290]];
    //    cell.userLabel.text = [NSString stringWithFormat:@"%@", model.playsCounts];
    float my = [model.playsCounts floatValue];
    
    if (my >= 10000) {
        my = my /10000 ;
        cell.userLabel.text = [NSString stringWithFormat:@"%.1lf万",my];
    }else{
        cell.userLabel.text = [NSString stringWithFormat:@"%@",model.playsCounts];
    }
    
    
    cell.setLabel.text = [NSString stringWithFormat:@"%@集", model.tracksCounts];
    // cell.introLabel.text = model.intro;
    //  [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.albumCoverUrl290]];
    
    if ([cell.userLabel.text isEqualToString:@"0"]) {
        cell.userImage.hidden = YES;
        cell.userLabel.text = @"";
        cell.setImage.frame = CGRectMake(95, 78, 10, 10);
        cell.setLabel.frame = CGRectMake(112, 75, 65, 15);
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    recommendModel *model = [recommendHelper sharedInstancetype].movieArray[indexPath.row];
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
