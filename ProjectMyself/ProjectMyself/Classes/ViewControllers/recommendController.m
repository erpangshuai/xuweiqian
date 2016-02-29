//
//  recommendController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "recommendController.h"
#import "recommendHelper.h"
#import "recommendCell.h"
#import "TopFiftyCell.h"
#import "sectionModel.h"
#import "SDCycleScrollView.h"
#import "footView.h"
#import "TopModel.h"
#import "UIImageView+WebCache.h"
#import "recommendModel.h"
#import "ListController.h"
#import "RadioDetailViewController.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
@interface recommendController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, SDCycleScrollViewDelegate>

@property(nonatomic,strong)UITableView *bigTableView;

@property(nonatomic,retain)UIScrollView *mainScrollView;
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation recommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[recommendHelper sharedInstancetype]downLoadDataFinished:^{
        [self.bigTableView reloadData];
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.bigTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-112) style:UITableViewStylePlain];
    [self.view addSubview:self.bigTableView];
    self.bigTableView.dataSource = self;
    self.bigTableView.delegate = self;
    
    [self.bigTableView registerClass:[recommendCell class] forCellReuseIdentifier:@"recommend"];
    [self.bigTableView registerClass:[TopFiftyCell class] forCellReuseIdentifier:@"TopFiftyCell"];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 11;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
//        sectionModel *model = [recommendHelper sharedInstancetype].sectionArray[1];
//        return model.list.count;
        return 3;
    }
    
}
#pragma mark - 头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 150)];
        testView.backgroundColor = [UIColor grayColor];
        
        SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, screenWidth, 150) imageURLStringsGroup:nil];
        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView2.delegate = self;
        cycleScrollView2.dotColor = [UIColor purpleColor];// 自定义分页控件小圆标颜色
        [testView addSubview:cycleScrollView2];
        
        cycleScrollView2.imageURLStringsGroup = @[@"http://fdfs.xmcdn.com/group9/M00/9B/E6/wKgDYlZFkoWBNDq_AAILkd9e4JU468_android_large.jpg",@"http://fdfs.xmcdn.com/group13/M07/9B/8E/wKgDXVZERg-CzwfsAAJhGBM5HJk102_android_large.jpg",@"http://fdfs.xmcdn.com/group10/M07/9B/E7/wKgDaVZFirOAfyabAAII7iKX9oE242_android_large.jpg",@"http://fdfs.xmcdn.com/group7/M04/9B/CD/wKgDWlZEamGwGcRAAALUtjIJKVk291_android_large.jpg",@"http://fdfs.xmcdn.com/group11/M00/8D/5B/wKgDa1ZCtEugKNAyAAJZ9tDAKNQ513_android_large.jpg",@"http://fdfs.xmcdn.com/group11/M06/8E/FF/wKgDa1ZFV02RE2uJAAH2aSEJyQg490_android_large.jpg",@"http://fdfs.xmcdn.com/group13/M0A/99/0F/wKgDXlZAbtPBSNLaAAK63qi73nc086_android_large.jpg"];
        return testView;
        
    }else{
        sectionModel *model = [recommendHelper sharedInstancetype].sectionArray[section-1];
        footView *footerView = [[footView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 25) withLeaderImage:@"箭头" withTextLabel:model.title withRightButton:@"更多"];
        footerView.backgroundColor = [UIColor whiteColor];
        
        [footerView.rightButton addTarget:self action:@selector(rightButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        footerView.rightButton.tag = section;
        return footerView;
        
    }
    
}
- (void)rightButtonDidClicked:(UIButton*)sender{
    ListController *listVC = [[ListController alloc]init];
    [self.navigationController pushViewController:listVC animated:YES];
    listVC.index = sender.tag;
    
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
//    NSLog(@"--点击了第%ld张图片", index);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 150;    // 一开始 是 40 他是 scrollView 的高度 就是 header 的高度
    
    if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 150;
    }else{
        return 25;
    }
    
}

#pragma mark-- 尾部
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 12)];
    footView.backgroundColor = [UIColor lightGrayColor];
    return footView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 14;
}

#pragma mark - scrollview 代理方法

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    self.pageControl.currentPage = page;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        TopFiftyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopFiftyCell" forIndexPath:indexPath];
        
        TopModel *model = [recommendHelper sharedInstancetype].topArray.firstObject;
        
        [cell.awardImage sd_setImageWithURL:[NSURL URLWithString:model.coverPath]];
        cell.titleLabel.text = model.title;
        cell.awardImage.layer.cornerRadius = 30;
        cell.awardImage.clipsToBounds = YES;
        cell.introLabel.text = model.subtitle;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }else{
        recommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommend" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        sectionModel *model1 = [recommendHelper sharedInstancetype].sectionArray[indexPath.section - 1];
        
        recommendModel *model = [[recommendModel alloc]init];
        [model setValuesForKeysWithDictionary:model1.list[indexPath.row]];
        cell.titleLabel.text = model.title;
        cell.introLabel.text = model.intro;
        
        float my = [model.playsCounts floatValue];
        
        if (my >= 10000) {
            my = my /10000 ;
            cell.userLabel.text = [NSString stringWithFormat:@"%.1lf万",my];
        }else{
            cell.userLabel.text = [NSString stringWithFormat:@"%@",model.playsCounts];
        }

        cell.setLabel.text = [NSString stringWithFormat:@"%@集", model.tracksCounts];
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.albumCoverUrl290]];
        
        if ([cell.userLabel.text isEqualToString:@"0"]) {
            cell.userImage.hidden = YES;
            cell.userLabel.text = @"";
            cell.setImage.frame = CGRectMake(95, 78, 10, 10);
            cell.setLabel.frame = CGRectMake(112, 75, 65, 15);
        }
        // NSLog(@"%@", cell.userLabel.text);
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0)
    {
        return 80;
    }
    else
    {
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ListController *listVC = [[ListController alloc]init];
        [self.navigationController pushViewController:listVC animated:YES];
        listVC.tagIndex = indexPath.section;
    }else{
        sectionModel *model1 = [recommendHelper sharedInstancetype].sectionArray[indexPath.section - 1];
        recommendModel *model = [[recommendModel alloc]init];
        [model setValuesForKeysWithDictionary:model1.list[indexPath.row]];
        
        RadioDetailViewController *radio = [[RadioDetailViewController alloc]init];
        [self.navigationController pushViewController:radio animated:YES];
        
        radio.albumId = [NSString stringWithFormat:@"%@", model.albumId];
        radio.position = [NSString stringWithFormat:@"%ld",indexPath.row];

        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [self.timer invalidate];
    self.timer  = nil;
    
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
