//
//  singLoactionViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/27.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "singLoactionViewController.h"

@interface singLoactionViewController ()
//录音器
@property (nonatomic, strong) AVAudioRecorder *recorder;
//播放器
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSDictionary *recorderSettingsDict;

//定时器
@property (nonatomic, strong)NSTimer *timer;
//图片组
@property (nonatomic, strong)NSMutableArray *volumImages;
@property (nonatomic, assign)double lowPassResults;
@property (weak, nonatomic) IBOutlet UIImageView *backimage;
@property (weak, nonatomic) IBOutlet UIButton *luzhibut;

//录音名字
@property (nonatomic, strong)NSString *playName;

@property (nonatomic, assign) BOOL recording;
@end

@implementation singLoactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    _playName = [NSString stringWithFormat:@"%@/play.aac",docDir];
    //录音设置
    _recorderSettingsDict = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,
    [NSNumber numberWithInt:1000.0],AVSampleRateKey,
    [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
    [NSNumber numberWithInt:8],AVLinearPCMBitDepthKey,
    [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
    [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey, nil];
    
    //音量图片数组
    _volumImages = [[NSMutableArray alloc]initWithObjects:@"RecordingSignal001",@"RecordingSignal002",@"RecordingSignal003",
                   @"RecordingSignal004", @"RecordingSignal005",@"RecordingSignal006",
                   @"RecordingSignal007",@"RecordingSignal008",   nil];
    
    self.recording = NO;
    [self.luzhibut setTitle:@"录音" forState:UIControlStateNormal];

    self.backimage.image = [UIImage imageNamed:@"RecordingBkg.png"];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
    image.frame = self.view.bounds;
    image.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:image atIndex:0];

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)luyinAction:(UIButton *)sender {
    
    if (!_recording) {
        
        [self.luzhibut  setTitle:@"停止" forState:UIControlStateNormal];
        NSError *error = nil;
        _recorder = [[AVAudioRecorder alloc]initWithURL:[NSURL URLWithString:_playName] settings:_recorderSettingsDict error:&error];
        _recording = YES;
        if (_recorder) {
            _recorder.meteringEnabled = YES;
            [_recorder prepareToRecord];
            [_recorder record];
            
            //启动定时器
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(levelTimer:) userInfo:nil repeats:YES];
        }else
        {
            int errorCode = CFSwapInt32HostToBig ([error code]);
//            NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
        }
    }else{
        [self.luzhibut setTitle:@"录音" forState:UIControlStateNormal];
        //录音停止
        [_recorder stop];
        _recorder = nil;
        //结束定时器
        [_timer invalidate];
        _timer = nil;
        //图片重置
        _soundLoadingImageView.image = [UIImage imageNamed:[_volumImages objectAtIndex:0]];
        self.recording = NO;
    }
    
    
}
- (IBAction)playAction:(UIButton *)sender {
    
    NSError *playerError;
    
    //播放
//    NSLog(@"播放录音");
    _player = nil;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:_playName] error:&playerError];
    
    if (_player == nil)
    {
//        NSLog(@"ERror creating player: %@", [playerError description]);
    }else{
        [_player play];
    }

}

-(void)levelTimer:(NSTimer*)timer_
{
    //call to refresh meter values刷新平均和峰值功率,此计数是以对数刻度计量的,-160表示完全安静，0表示最大输入值
    [_recorder updateMeters];
    const double ALPHA = 0.05;
    double peakPowerForChannel = pow(10, (0.05 * [_recorder peakPowerForChannel:0]));
    _lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * _lowPassResults;
    
//    NSLog(@"Average input: %f Peak input: %f Low pass results: %f", [_recorder averagePowerForChannel:0], [_recorder peakPowerForChannel:0], _lowPassResults);
    
    if (_lowPassResults>=0.8) {
        _soundLoadingImageView.image = [UIImage imageNamed:[_volumImages objectAtIndex:7]];
    }else if(_lowPassResults>=0.7){
        _soundLoadingImageView.image = [UIImage imageNamed:[_volumImages objectAtIndex:6]];
    }else if(_lowPassResults>=0.6){
        _soundLoadingImageView.image = [UIImage imageNamed:[_volumImages objectAtIndex:5]];
    }else if(_lowPassResults>=0.5){
        _soundLoadingImageView.image = [UIImage imageNamed:[_volumImages objectAtIndex:4]];
    }else if(_lowPassResults>=0.4){
        _soundLoadingImageView.image = [UIImage imageNamed:[_volumImages objectAtIndex:3]];
    }else if(_lowPassResults>=0.3){
        _soundLoadingImageView.image = [UIImage imageNamed:[_volumImages objectAtIndex:2]];
    }else if(_lowPassResults>=0.2){
        _soundLoadingImageView.image = [UIImage imageNamed:[_volumImages objectAtIndex:1]];
    }else if(_lowPassResults>=0.1){
        _soundLoadingImageView.image = [UIImage imageNamed:[_volumImages objectAtIndex:0]];
    }else{
        _soundLoadingImageView.image = [UIImage imageNamed:[_volumImages objectAtIndex:0]];
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
