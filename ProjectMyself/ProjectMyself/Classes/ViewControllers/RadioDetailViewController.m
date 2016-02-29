//
//  RadioDetailViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "RadioDetailViewController.h"
#import "DetailModel.h"
#import "DetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "detailTableViewModel.h"
#import "PlayMusicController.h"

@interface RadioDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *musicTableView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *tracksLabel;



@property(nonatomic,strong)NSMutableArray *dataArray1;
@end

@implementation RadioDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downLoadGiftDataFinish:^{
        [self.musicTableView reloadData];
    }];
    
//    self.view.backgroundColor = [UIColor cyanColor];
    
    self.musicTableView.dataSource = self;
    self.musicTableView.delegate = self;

    [self.musicTableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 20;
    
    
    // Do any additional setup after loading the view from its nib.
}
- (NSMutableArray *)dataArray1{
    if (!_dataArray1) {
        _dataArray1 = [NSMutableArray array];
    }
    return _dataArray1;
}
- (NSMutableArray *)dataArray2{
    if (!_dataArray2) {
        _dataArray2 = [NSMutableArray array];
    }
    return _dataArray2;
}


-(void)downLoadGiftDataFinish:(void(^)())result{
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
     NSURL *url = [[NSURL alloc]init];
     url = [NSURL URLWithString:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%@/true/1/20?position=%@&albumId=%@&isAsc=true&device=android&title=%%E7%%B2%%BE%%E9%%80%%89%%7C%%E6%%AD%%8C%%E5%%8D%%95&pageSize=20",self.albumId,self.position,self.albumId]];
//     NSLog(@"---%@--", url);
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
         NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         
         NSDictionary *albumDict = resultDict[@"album"];
         DetailModel *model1 = [[DetailModel alloc]init];
         model1.nickname = albumDict[@"nickname"];
         model1.coverLarge = albumDict[@"coverLarge"];
         model1.avatarPath = albumDict[@"avatarPath"];
         model1.tags = albumDict[@"tags"];
         model1.intro = albumDict[@"intro"];
         model1.tracks = albumDict[@"tracks"];
//         NSLog(@"%ld", (long)model1.tracks);
         self.nickNameLabel.text = model1.nickname;
         [self.coverImageView  sd_setImageWithURL:[NSURL URLWithString:model1.coverLarge]];
         [self.avatarImageView   sd_setImageWithURL:[NSURL  URLWithString:model1.avatarPath]];
         self.tagsLabel.text = model1.tags;
         self.introLabel.text = model1.intro;
         self.tracksLabel.text = [NSString stringWithFormat:@"共%ld集", (long)model1.tracks ];
         NSDictionary *tracksDict = resultDict[@"tracks"];
         NSArray *array = tracksDict[@"list"];
         for (NSDictionary *dict in array) {
             detailTableViewModel  *model2 = [[detailTableViewModel  alloc] init];
             [model2 setValuesForKeysWithDictionary:dict];
             [self.dataArray2 addObject:model2];
             
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             result();
         });

     }];
 });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray2.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    detailTableViewModel *model = self.dataArray2[indexPath.row];
    [cell setCellDataWithModel:model];
    
    UIColor *color  = [[UIColor alloc] initWithRed:255.0/255 green:222.0/255 blue:249.0/255 alpha:1.0];
    cell.backgroundColor = color;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayMusicController *playVC = [[PlayMusicController alloc]init];
   playVC.receiveModel = self.dataArray2[indexPath.row];
   playVC.dataArray3 = self.dataArray2;
//    self.playVC.index = indexPath.row;
    [self.navigationController pushViewController:playVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
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
