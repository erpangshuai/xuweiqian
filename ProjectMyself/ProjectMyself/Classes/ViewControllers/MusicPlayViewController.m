//
//  MusicPlayViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/30.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "MusicPlayViewController.h"

@interface MusicPlayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *PreogressSlider;
@property (weak, nonatomic) IBOutlet UISlider *VolumeSlider;
@property (weak, nonatomic) IBOutlet UIButton *playBUtton;
@property (weak, nonatomic) IBOutlet UITableView *LyricTableView;

@end

@implementation MusicPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)lastMusicAction:(UIButton *)sender {
}
- (IBAction)playMusicAction:(UIButton *)sender {
}
- (IBAction)nextMusicAction:(UIButton *)sender {
}
- (IBAction)changeTimeAction:(UISlider *)sender {
}
- (IBAction)changeVolumeAction:(UISlider *)sender {
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
