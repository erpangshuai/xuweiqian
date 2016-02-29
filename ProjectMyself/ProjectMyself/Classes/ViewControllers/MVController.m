//
//  MVController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "MVController.h"
#import "MVCollectionViewCell.h"
#import "MVModel.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
//#import <AVFoundation/AVFoundation.h>
#import "MusicViewController.h"
#import "MJRefresh.h"
#import "SSVideoPlayContainer.h"
#import "SSVideoPlayController.h"

#define RankWidth [UIScreen mainScreen].bounds.size.width
#define RankHeight [UIScreen mainScreen].bounds.size.height
#define Url @"http://spark.api.xiami.com/api?api_key=263b63d85992a30cc6030aff03c9dfd0&call_id=1446690824877&av=android_105&v=5.0&app_v=5030200&os_v=19_4.4.4&ch=702006&network=1&device_id=867822024649849&platform_id=1&gps=0.0%2C0.0&lg=1&utdid=VYZVPTIG4FIDADl%2BMJXO9h3A&resolution=1280*720&method=mv.music-list&order=recommend&page=1&limit=20&new=1&language=0&gender=0&tag=0&proxy=0&api_sig=717fb4383035e37013d1961f5870e8d9"
@interface MVController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView *MVCollectionView;

@property(nonatomic, strong)NSMutableArray *dataArray;

//@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong)UIRefreshControl *control;
//@property (nonatomic, strong)MPMoviePlayerController *moviePlayerViewController;
@end

@implementation MVController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置每一个元素的大小
    layout.itemSize = CGSizeMake(160, 140);
    //设置内边距大小
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20                                                                            , 20);
    

    self.MVCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, RankWidth, RankHeight-116) collectionViewLayout:layout];
    
    self.MVCollectionView.delegate = self;
    self.MVCollectionView.dataSource = self;
    
    [self.MVCollectionView registerNib:[UINib nibWithNibName:@"MVCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"layout"];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.MVCollectionView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.MVCollectionView];
   
    [self downLoadGiftDataFinished:^{
        [self.MVCollectionView reloadData];
    } withIndex:self.index];

//    刷新
    self.control = [[UIRefreshControl alloc]init];
    _control.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    //菊花颜色
    self.control.tintColor = [UIColor  colorWithRed:1.000 green:0.046 blue:0.039 alpha:1.000];
    [self.control addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.MVCollectionView addSubview:self.control];

    // Do any additional setup after loading the view.
}

- (void)refresh{
    //过多久执行方法
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"数据刷新中，上次更新日期 %@",
                             [formatter stringFromDate:[NSDate date]]];
    self.control.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:1.5];

}

- (void)refreshData{
    
    [self downLoadGiftDataFinished:^{
        [self.MVCollectionView reloadData];
        self.index = (self.MVCollectionView.contentOffset.y - 1515) / 2000 ;
        
        self.index = self.index + 1;
    } withIndex:self.index];
    [self.control endRefreshing];
}

#pragma mark - 数据请求
-(void)downLoadGiftDataFinished:(void(^)())result withIndex:(NSInteger)index{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [[NSURL alloc] init];
       url = [NSURL URLWithString:Url];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary *Dict1 = resultDict[@"data"];
            
            NSArray *array = Dict1[@"mvs"];
            
            for (NSDictionary *dict in array) {
                
                NSArray *dictArray = dict[@"artist"];
                NSDictionary *Videodict = dict[@"video"];
                
                MVModel *Model = [[MVModel alloc]init];
                Model.title = dict[@"title"];
                //self.titleStr = Model.title;
                NSString *imageStr = [dict[@"mv_cover"] stringByReplacingOccurrencesOfString:@"_420x280_.webp" withString:@""];
                Model.mv_cover = imageStr;
                
//                Model.artist_name = [dictArray[0] objectForKey:@"artist_name"];
                
                Model.url = Videodict[@"url"];
                
                [self.dataArray addObject:Model];
//                NSLog(@"%@", Model);
//                
//                
//                NSLog(@"=========%@",self.dataArray);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                result();
            });
            
        }];
        
    });
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
  
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MVCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"layout" forIndexPath:indexPath];
    
    MVModel *model = self.dataArray[indexPath.row];
    [cell setCellDataWithModel:model];
    
    return cell;
}

#pragma mark-- 视频播放

//- (MPMoviePlayerController *)moviePlayerViewController{
//    if (!_moviePlayerViewController) {
//        _moviePlayerViewController = [[MPMoviePlayerController alloc]init];
//    }
//    return _moviePlayerViewController;
//    
////}
//- (AVPlayer *)player{
//    if (!_player) {
//        _player = [[AVPlayer alloc]init];
//    }
//    return _player;
//}

- (void)playerWithUrl:(MVModel *)model{

    
    /*
    //弄个view放播放器
    UIView * playView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:playView];
    
    UIView *butView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-200, [UIScreen mainScreen].bounds.size.width, 200)];
    butView.backgroundColor = [UIColor whiteColor];
    UIButton *offbut = [UIButton buttonWithType:UIButtonTypeSystem];
    offbut.frame = CGRectMake(0,0, 100, 50);
    [offbut setTitle:@"关闭" forState:UIControlStateNormal];
    [butView addSubview:offbut];
    [playView addSubview:butView];
    [offbut addTarget:self action:@selector(offaction) forControlEvents:UIControlEventTouchUpInside];
    
    
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:model.url] options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
//    playerLayer.frame = self.view.layer.bounds;
    playerLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-200);
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    //这个效果最好了
    playerLayer.videoGravity = AVLayerVideoGravityResize;
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [playView.layer addSublayer:playerLayer];
    [_player play];
    */
    
    //第三方的运用
    NSMutableArray *videoList = [NSMutableArray array];
    SSVideoModel *mod = [[SSVideoModel alloc]init];
    mod.path = model.url;
    mod.name = model.title;
    [videoList addObject:mod];
    SSVideoPlayController *palyController = [[SSVideoPlayController alloc]initWithVideoList:videoList];
    SSVideoPlayContainer *playcontainer = [[SSVideoPlayContainer alloc]initWithRootViewController:palyController];
    [self presentViewController:playcontainer animated:NO completion:nil];
    
}
/*
- (void)offaction{
    [_player pause];
//    [[self.view.layer.sublayers lastObject] removeFromSuperlayer];
    
    MusicViewController *muvc = [[MusicViewController alloc]init];
    [self.navigationController pushViewController:muvc animated:YES];
}
*/

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MVModel *model = self.dataArray[indexPath.row];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *playMV = [UIAlertAction actionWithTitle:@"播放" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self playerWithUrl:model];
       
//        [self presentMoviePlayerViewControllerAnimated:_moviePlayerViewController];
    }];
    
    UIAlertAction *cancleMV = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //取消cell的状态
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }];
    
    //绑定事件
    [alertVC addAction:playMV];
    [alertVC addAction:cancleMV];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
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
