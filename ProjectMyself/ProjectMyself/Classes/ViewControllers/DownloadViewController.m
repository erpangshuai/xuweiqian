//
//  DownloadViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/29.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "DownloadViewController.h"
#import "MusicListViewController.h"
#import "SecondViewController.h"
@interface DownloadViewController ()
@property (nonatomic, strong)MusicListViewController *mlvc;
@property (nonatomic, strong)SecondViewController *svc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    self.mlvc = [[MusicListViewController alloc]initWithNibName:@"MusicListViewController" bundle:nil];
    self.svc = [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
    [self addChildViewController:self.mlvc];
    [self addChildViewController:self.svc];
    [self.view addSubview:self.mlvc.view];
    //将segment带到最前边
    [self.view bringSubviewToFront:self.segment];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)segment:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            if (self.mlvc.view.superview == nil) {
                [self.svc.view removeFromSuperview];
                [self.view addSubview:self.mlvc.view];
                [self.view bringSubviewToFront:self.segment];
            }
            break;
            case 1:
            if (self.svc.view.superview == nil) {
                [self.mlvc.view removeFromSuperview];
                [self.view addSubview:self.svc.view];
                [self.view bringSubviewToFront:self.segment];
            }
            break;
        default:
            break;
    }
    
    
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
