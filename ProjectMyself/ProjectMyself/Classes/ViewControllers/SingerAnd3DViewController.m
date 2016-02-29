//
//  SingerAnd3DViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "SingerAnd3DViewController.h"
#import "AllViewController.h"
#import "FanchangViewController.h"
#import "MovieViewController.h"

#define k_FontSize         (arc4random() % 18) + 13
@interface SingerAnd3DViewController ()

@end

@implementation SingerAnd3DViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self labelCloud];
    // Do any additional setup after loading the view from its nib.
}

-(void)labelCloud{
    NSArray *colorArray = @[[UIColor greenColor],[UIColor blueColor],[UIColor purpleColor],[UIColor redColor],[UIColor grayColor],[UIColor magentaColor],[UIColor brownColor]];
    NSMutableArray *titlesArray = [[NSMutableArray alloc] initWithObjects:@"全部",@"日本",@"欧美",@"华语",@"韩国",@"音乐人",@"翻唱",@"电影原声",@"其他", nil];
    NSMutableArray *frameArray = [[NSMutableArray alloc] initWithObjects:@"{{80, 92}, {240, 30}}",@"{{46, 228}, {240, 30}}",@"{{152, 124}, {240, 30}}",@"{{84, 146}, {240, 30}}",@"{{200, 175}, {240, 30}}",@"{{80, 190}, {250, 30}}",@"{{152, 238}, {250, 30}}",@"{{190, 269}, {250, 30}}",@"{{67, 290}, {250, 30}}", nil];
    for (UILabel *label in [self.view subviews]) {
        label.text = [titlesArray objectAtIndex:0];
        [titlesArray removeObjectAtIndex:0];
        label.textColor = colorArray[arc4random()%[colorArray count]];
        label.font = [UIFont systemFontOfSize:k_FontSize];
        label.frame = CGRectZero;
        label.center = self.view.center;
        label.userInteractionEnabled = YES;
        
        [UIView animateWithDuration:2 animations:^{
            label.frame = CGRectFromString(frameArray[0]);
            [frameArray removeObjectAtIndex:0];
        }completion:nil];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClik:)]];
    }
    
}
/**
 *  监听label的点击
 */
- (void)labelClik:(UITapGestureRecognizer *)recognizer
{
    //获得点击的label、
    UILabel *label = (UILabel *)recognizer.view;
    
    //初始化控制器
    AllViewController *vc = [[AllViewController alloc]init];
    FanchangViewController *fancVC = [[FanchangViewController alloc]init];
    MovieViewController *movieVC = [[MovieViewController alloc]init];
    
    switch (label.tag) {
        case 0:
            [self.navigationController pushViewController:vc animated:YES];
            vc.title = @"全部";
            break;
            case 1:
            [self.navigationController pushViewController:vc animated:YES];
            vc.title = @"日本";
        case 2:
            
            [self.navigationController pushViewController:vc animated:YES];
            vc.title = @"欧美";
            break;
            
        case 3:
            [self.navigationController pushViewController:vc animated:YES];
            vc.title = @"华语";
            break;
            
        case 4:
            [self.navigationController pushViewController:vc animated:YES];
            vc.title = @"韩国";
            break;
            
        case 5:
            [self.navigationController pushViewController:vc animated:YES];
            vc.title = @"其他";
            break;
            
        case 6:
            [self.navigationController pushViewController:vc animated:YES];
            vc.title = @"音乐人";
            break;
            
        case 7:
            [self.navigationController pushViewController:fancVC animated:YES];
            vc.title = @"翻唱";
            break;
            
        case 8:
            [self.navigationController pushViewController:movieVC animated:YES];
            vc.title = @"电影原声";
            break;
        default:
            break;
    }
    
    vc.index = label.tag;
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
