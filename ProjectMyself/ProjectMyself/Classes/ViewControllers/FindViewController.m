//
//  FindViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "FindViewController.h"
#import "singLoactionViewController.h"
#import "SingerAnd3DViewController.h"
#import "ThreeDViewController.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface FindViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UIScrollView *bigScrollView;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)UILabel *bottomLabel;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.bigScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 52, screenWidth, screenHeight)];
    self.bigScrollView.pagingEnabled = YES;
    self.bigScrollView.backgroundColor = [UIColor cyanColor];
    self.bigScrollView.contentSize = CGSizeMake(screenWidth * 3, 0);
    [self.view addSubview:self.bigScrollView];
    
    self.bigScrollView.delegate = self;
    
    [self creatTopscrollViewButton];
    
    [self setSmallControllers];
    
    [self creatSmallViews];

    
    // Do any additional setup after loading the view.
}
//顶部标题
-(void)creatTopscrollViewButton{
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, screenWidth, 50)];
    self.topView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.topView];
    
    NSArray *namearray = @[@"艺人|歌星",@"3D奇妙体验馆",@"我是歌唱家"];
    for (int i = 0; i < namearray.count; i++) {
        UIButton *nameButton = [[UIButton alloc]initWithFrame:CGRectMake(i*screenWidth/3, 8, screenWidth/3, 35)];
        [self.topView addSubview:nameButton];
        [nameButton setTitle:namearray[i] forState:UIControlStateNormal];
        nameButton.tag = i;
        [nameButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 47, screenWidth/3, 2)];
    self.bottomLabel.backgroundColor = [UIColor grayColor];
    [self.topView addSubview:self.bottomLabel];
    
    
}
- (void)buttonDidClicked:(UIButton *)sender{
    
    self.bigScrollView.contentOffset = CGPointMake(sender.tag*screenWidth, 0);
    self.bottomLabel.frame = CGRectMake(sender.tag*screenWidth/3, 47, screenWidth/3, 2);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.index = scrollView.contentOffset.x/screenWidth;
    [UIView animateWithDuration:0.1 animations:^{
        self.bottomLabel.frame = CGRectMake(self.index*screenWidth/3, 47, screenWidth/3, 2);
    }completion:^(BOOL finished) {
        
    }];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    for (UIView *view in self.bigScrollView.subviews) {
        if ([view isMemberOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
}

-(void)setSmallControllers{
    SingerAnd3DViewController *sVC = [[SingerAnd3DViewController alloc]init];
    [self addChildViewController:sVC];
    
    ThreeDViewController *threeVC = [[ThreeDViewController alloc]init];
    [self addChildViewController:threeVC];
    
    singLoactionViewController *singVC = [[singLoactionViewController alloc]init];
    [self addChildViewController:singVC];
    
}


-(void)creatSmallViews{
    
    SingerAnd3DViewController *firstVC = [self.childViewControllers firstObject];
    [self.bigScrollView addSubview:firstVC.view];
    firstVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight - 116) ;
    
    ThreeDViewController *secondVC = self.childViewControllers[1];
    [self.bigScrollView addSubview:secondVC.view];
    secondVC.view.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeight-116);
    
    singLoactionViewController *thirdVC = self.childViewControllers[2];
    [self.bigScrollView addSubview:thirdVC.view];
    thirdVC.view.frame = CGRectMake(screenWidth*2, 0, screenWidth, screenHeight - 116);

    
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
