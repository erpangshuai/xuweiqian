//
//  MusicViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "MusicViewController.h"
#import "recommendController.h"
#import "rankController.h"
#import "songListController.h"
#import "radioController.h"
#import "MVController.h"
#import "MyViewController.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface MusicViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIScrollView *bigScrollView;
@property(nonatomic,strong)UILabel *bottomLabel;
@property(nonatomic,assign)NSInteger index;

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"音乐馆";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;                                                               
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"我的" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = left;

    
    self.bigScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeight-116)];
    self.bigScrollView.pagingEnabled = YES;
    self.bigScrollView.backgroundColor = [UIColor greenColor];
    self.bigScrollView.contentSize = CGSizeMake(screenWidth * 5, 0);
    [self.view addSubview:self.bigScrollView];
    
    self.bigScrollView.delegate = self;
    [self creatTopScrollViewButton];
    
    [self setSmallControllers];
    
     [self creatSmallViews];
    
    
    //set NavigationBar 背景颜色&title 颜色
//    [self.navigationController.navigationBar setBarTintColor:[UIColor cyanColor]];
    // Do any additional setup after loading the view.
}


- (void)leftAction{
//    MyViewController *myVC = [[MyViewController alloc]init];
//    [self.navigationController pushViewController:myVC animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//列表
-(void)creatTopScrollViewButton
{
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
    self.topView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.topView];
    
    
    NSArray *nameArray = @[@"推荐",@"排行",@"歌单",@"电台",@"MV"];
    for (int i = 0; i < nameArray.count; i++)
    {
        UIButton *nameButton = [[UIButton alloc]initWithFrame:CGRectMake(i * screenWidth / 5, 10, screenWidth / 5, 30)];
        [self.topView addSubview:nameButton];
        [nameButton setTitle:nameArray[i] forState:UIControlStateNormal];
        nameButton.tag = i;
        [nameButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, screenWidth / 5, 2)];
    self.bottomLabel.backgroundColor = [UIColor orangeColor];
    [self.topView addSubview:self.bottomLabel];
    
    
}

-(void)buttonDidClicked:(UIButton*)sender
{
    
    self.bigScrollView.contentOffset = CGPointMake(sender.tag * screenWidth, 0);
    self.bottomLabel.frame = CGRectMake(sender.tag * screenWidth / 5, 40, screenWidth / 5, 2);
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.index = scrollView.contentOffset.x / screenWidth;
    [UIView animateWithDuration:0.1 animations:^{
        self.bottomLabel.frame = CGRectMake(self.index * screenWidth / 5, 40, screenWidth / 5, 2) ;
        
    } completion:^(BOOL finished) {
        
    }];
    
}
// // // // 关键一步
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (UIView *view in self.bigScrollView.subviews) {
        if ([view isMemberOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
}

-(void)setSmallControllers{
    recommendController *recommendVC = [[recommendController alloc]init];
    [self addChildViewController:recommendVC];
    
    rankController *rankVC = [[rankController alloc]init];
    [self addChildViewController:rankVC];
    
    songListController *songVC = [[songListController alloc]init];
    [self addChildViewController:songVC];
    
    radioController *radioVC = [[radioController alloc]init];
    [self addChildViewController:radioVC];

    MVController *mvVC = [[MVController alloc]init];
    [self addChildViewController:mvVC];
    
    
}

-(void)creatSmallViews
{
    recommendController *firstVC = [self.childViewControllers firstObject];
    [self.bigScrollView addSubview:firstVC.view];
    firstVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight - 116) ;
    
    rankController *secondVC = self.childViewControllers[1];
    [self.bigScrollView addSubview:secondVC.view];
    secondVC.view.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeight - 116);
    
    songListController *thirdVC = self.childViewControllers[2];
    [self.bigScrollView addSubview:thirdVC.view];
    thirdVC.view.frame = CGRectMake(screenWidth * 2, 0, screenWidth, screenHeight - 116);
    
    radioController *fourthVC = self.childViewControllers[3];
    [self.bigScrollView addSubview:fourthVC.view];
    fourthVC.view.frame = CGRectMake(screenWidth * 3, 0, screenWidth, screenHeight - 116);

    MVController *fiveVC = self.childViewControllers[4];
    [self.bigScrollView addSubview:fiveVC.view];
    fiveVC.view.frame = CGRectMake(screenWidth * 4, 0, screenWidth, screenHeight - 116);
   
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
