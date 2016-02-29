//
//  LocalityViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "LocalityViewController.h"
#import "RootViewController.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
@interface LocalityViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bigScrollView;

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UILabel *bottomLabel;

@property(nonatomic,assign)NSInteger index;
@end

@implementation LocalityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"本地音乐";
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [[UIColor alloc] initWithRed:255.0/255 green:222.0/255 blue:249.0/255 alpha:1.0];
    
    //左视图
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"我的" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
                             
    self.navigationItem.leftBarButtonItem = left;
    //滚动图
    self.bigScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 48, self.view.frame.size.width,self.view.frame.size.height + 20)];
    self.bigScrollView.pagingEnabled = YES;
    //    self.bigScrollView.backgroundColor = [UIColor blueColor];
    self.bigScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 4, 0);
    [self.view addSubview:self.bigScrollView];
    self.bigScrollView.delegate = self;
    
    [self creatTopScrollViewButton];
    [self setSmallControllers];
    
    [self creatSmallViews];

    // Do any additional setup after loading the view.
}

- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatTopScrollViewButton{
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 48)];
    self.topView.backgroundColor = [UIColor blueColor];
    
    NSArray *nameArray = @[@"我的歌单",@"歌手",@"专辑",@"文件夹"];
    for (int i = 0; i <nameArray.count; i++) {
        UIButton *namebutton = [[UIButton alloc]initWithFrame:CGRectMake(i*102, 10, 100, 30)];
        [self.topView addSubview:namebutton];
        [namebutton setTitle:nameArray[i] forState:UIControlStateNormal];
        namebutton.tag = i;
        [namebutton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 102, 2)];
    self.bottomLabel.backgroundColor = [UIColor orangeColor];
    [self.topView addSubview:self.bottomLabel];
    
    [self.view addSubview:self.topView];
}
-(void)buttonDidClick:(UIButton*)sender{
    self.bigScrollView.contentOffset = CGPointMake(sender.tag * self.view.frame.size.width, 0);
    self.bottomLabel.frame = CGRectMake(sender.tag * 102, 40, 102, 2);
 
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    self.index = scrollView.contentOffset.x/600;
    [UIView animateWithDuration:0.1 animations:^{
        self.bottomLabel.frame = CGRectMake(self.index *102, 40, 102, 1);
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

- (void)setSmallControllers{
    RootViewController *rvc = [[RootViewController alloc]init];
    [self addChildViewController:rvc];
    
    
}
- (void)creatSmallViews{
    
    RootViewController *firstVC = [self.childViewControllers firstObject];
    [self.bigScrollView addSubview:firstVC.view];
    firstVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight-116);
    
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
