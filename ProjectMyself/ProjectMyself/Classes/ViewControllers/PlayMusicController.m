//
//  PlayMusicController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "PlayMusicController.h"
#import "MusicPlayManager.h"
#import "UIImageView+WebCache.h"
#import "AudioPlayer.h"
@interface PlayMusicController ()
//歌曲图片
@property (weak, nonatomic) IBOutlet UIImageView *singerimageView;
//歌名
@property (weak, nonatomic) IBOutlet UILabel *songName;
//歌手名
@property (weak, nonatomic) IBOutlet UILabel *singerName;

//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *backgroundimageView;

//进度条
@property (weak, nonatomic) IBOutlet UISlider *PreogressSlider;

//开始时间
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;

//结束时间
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;


@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation PlayMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[MusicPlayManager shareInstance]downLoadDataFinished:^{
        [self updateUI];
    } withPlayModel:self.receiveModel];
    
    
    self.singerimageView.layer.masksToBounds = YES;
    self.singerimageView.layer.cornerRadius = CGRectGetWidth(self.singerimageView.frame)/2;
    
    self.PreogressSlider.value = 0;
    self.PreogressSlider.minimumValue = 0;
    self.PreogressSlider.minimumTrackTintColor = [UIColor redColor];

    
    [self.PreogressSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view from its nib.
}



#pragma mark  切歌
- (void)updateUI{
    self.reModel = [MusicPlayManager shareInstance].model;
    
    NSDictionary *dict = self.reModel.userInfo;
    self.singerName.text = dict[@"nickname"];
    self.songName.text = self.reModel.title;
    
    [self.backgroundimageView sd_setImageWithURL:[NSURL URLWithString:self.reModel.images.firstObject]];
    
//    [self.singerimageView sd_setImageWithURL:[NSURL URLWithString:self.reModel.images.firstObject]];
    

//
    self.PreogressSlider.maximumValue = [self.reModel.duration integerValue] / 1000;
    
    // 分钟
    NSInteger min = [self.reModel.duration integerValue] / 100 ;
    // 秒
    NSInteger seconds = [self.reModel.duration integerValue] / 1000 % 60;
    self.endTimeLabel.text = [NSString stringWithFormat:@"%ld:%ld",min,seconds];
    
    [self startPlay];

    
//    //设置唱片
//    [[MusicPlayManager shareInstance]prePareToplayWithModel:reModel];
//    //播放
//    [[MusicPlayManager shareInstance]play];
//    
//    //设置播放图片
//    [self.singerimageView sd_setImageWithURL:[NSURL URLWithString:reModel.albumImage]];
//    //填充
//    self.singerimageView.contentMode = 0;
//    //设置图片起始角度
//    self.singerimageView.transform = CGAffineTransformMakeRotation(0);
    
    
    
}
-(void)startPlay
{
    
    [[AudioPlayer sharedInstance]prepareWithURL:self.reModel.playUrl32];
    
    [AudioPlayer sharedInstance].delegate = self;
#warning 警告........
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self startPlay];
    [self updateUI];
    
}
-(void)sliderAction:(UISlider*)sender
{
    [[AudioPlayer sharedInstance]seekToTime:sender.value];
}

#pragma mark 上一曲
- (IBAction)lastMusicAction:(UIButton *)sender {
    self.index --;
    if (self.index == 1)
    {
        self.index = 20;
    }
    [self updateUI];
    [self startPlay];
}


#pragma mark-  播放
- (IBAction)PlayMusicAction:(UIButton *)sender {
    
    
    // 判断播放状态
    if ([AudioPlayer sharedInstance].isPlaying == YES)
    {
        [[AudioPlayer sharedInstance]pause];
    }
    else
    {
        [[AudioPlayer sharedInstance]play];
    }
    
    [sender setImage:[AudioPlayer sharedInstance].isPlaying ? [UIImage imageNamed:@"7.png"]:[UIImage imageNamed:@"5.png"] forState:UIControlStateNormal];
//    BOOL stata = [MusicPlayManager shareInstance].state;
//    if (stata == YES) {
//        [self.playButton setBackgroundImage:[UIImage imageNamed:@"7.png"] forState:UIControlStateNormal];
//        
//        
//    }else {
//        [self.playButton setBackgroundImage:[UIImage imageNamed:@"5.png"] forState:UIControlStateNormal];
//    }
//

}


#pragma mark -- 下一曲

- (IBAction)NextMusicAction:(UIButton *)sender {
    self.index ++;
    
    [self updateUI];
    [self startPlay];
}
-(void)playEndFinishe:(AudioPlayer*)player
{
    [self lastMusicAction:nil];
    
}



-(void)playWithPlayer:(AudioPlayer*)player withProgress:(float)progress
{
    self.PreogressSlider.value = progress;
    
    self.singerimageView.transform = CGAffineTransformRotate(self.singerimageView.transform, M_PI / 90) ;
    self.beginTimeLabel.text = [NSString stringWithFormat:@"%f",progress];
    // 随着时间向上移动
    // 根据时间获取下标
    
    // NSInteger index = []
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [[AudioPlayer sharedInstance].timer invalidate];
    [AudioPlayer sharedInstance].timer  = nil;
    
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
