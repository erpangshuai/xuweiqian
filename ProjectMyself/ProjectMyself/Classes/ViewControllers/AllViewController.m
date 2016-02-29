//
//  AllViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "AllViewController.h"
#import "AllSingerModel.h"
#import "SingerAnd3DViewCell.h"
#import "UIImageView+WebCache.h"

#define AllSingers @"http://spark.api.xiami.com/api?api_key=263b63d85992a30cc6030aff03c9dfd0&call_id=1446548834510&av=android_105&v=5.0&app_v=5030200&os_v=19_4.4.2&ch=700881&network=1&device_id=865335021534122&platform_id=1&gps=0.0%2C0.0&lg=1&utdid=VFuBD7l4tr8DAAdI7Ix8n%2FM2&resolution=1280*720&method=artist.music-list&new=1&language=0&gender=0&tag=0&proxy=0&api_sig=b160f5fe3072339b42ae71c24663ee10"
#define Japan @"http://spark.api.xiami.com/api?api_key=263b63d85992a30cc6030aff03c9dfd0&call_id=1446549956470&av=android_105&v=5.0&app_v=5030200&os_v=19_4.4.2&ch=700881&network=1&device_id=865335021534122&platform_id=1&gps=0.0%2C0.0&lg=1&utdid=VFuBD7l4tr8DAAdI7Ix8n%2FM2&resolution=1280*720&method=artist.music-list&new=1&language=2&gender=0&tag=0&proxy=0&api_sig=0125273f21d07ae3ecec639311a1afb4"
#define Chinese @"http://spark.api.xiami.com/api?api_key=263b63d85992a30cc6030aff03c9dfd0&call_id=1446549472879&av=android_105&v=5.0&app_v=5030200&os_v=19_4.4.2&ch=700881&network=1&device_id=865335021534122&platform_id=1&gps=0.0%2C0.0&lg=1&utdid=VFuBD7l4tr8DAAdI7Ix8n%2FM2&resolution=1280*720&method=artist.music-list&new=1&language=1&gender=0&tag=0&proxy=0&api_sig=d54f08770c8c1f704e0b136ffcc4427c"
#define American @"http://spark.api.xiami.com/api?api_key=263b63d85992a30cc6030aff03c9dfd0&call_id=1446548893093&av=android_105&v=5.0&app_v=5030200&os_v=19_4.4.2&ch=700881&network=1&device_id=865335021534122&platform_id=1&gps=0.0%2C0.0&lg=1&utdid=VFuBD7l4tr8DAAdI7Ix8n%2FM2&resolution=1280*720&method=artist.music-list&new=1&language=4&gender=0&tag=0&proxy=0&api_sig=2d68923b00be22d458ac6022cff9bf50"
#define Korea @"http://spark.api.xiami.com/api?api_key=263b63d85992a30cc6030aff03c9dfd0&call_id=1446550181039&av=android_105&v=5.0&app_v=5030200&os_v=19_4.4.2&ch=700881&network=1&device_id=865335021534122&platform_id=1&gps=0.0%2C0.0&lg=1&utdid=VFuBD7l4tr8DAAdI7Ix8n%2FM2&resolution=1280*720&method=artist.music-list&new=1&language=3&gender=0&tag=0&proxy=0&api_sig=5f2c5facfb0f37d69bef129b81fdca7c"
#define Musician @"http://spark.api.xiami.com/api?api_key=263b63d85992a30cc6030aff03c9dfd0&call_id=1446550243353&av=android_105&v=5.0&app_v=5030200&os_v=19_4.4.2&ch=700881&network=1&device_id=865335021534122&platform_id=1&gps=0.0%2C0.0&lg=1&utdid=VFuBD7l4tr8DAAdI7Ix8n%2FM2&resolution=1280*720&method=artist.music-list&new=1&language=6&gender=0&tag=0&proxy=0&api_sig=9d4f60faa811938b464cd296a2623419"
#define Other @"http://spark.api.xiami.com/api?api_key=263b63d85992a30cc6030aff03c9dfd0&call_id=1446550303726&av=android_105&v=5.0&app_v=5030200&os_v=19_4.4.2&ch=700881&network=1&device_id=865335021534122&platform_id=1&gps=0.0%2C0.0&lg=1&utdid=VFuBD7l4tr8DAAdI7Ix8n%2FM2&resolution=1280*720&method=artist.music-list&new=1&language=5&gender=0&tag=0&proxy=0&api_sig=af2925635b06a8cb875a532d77820ce2"

@interface AllViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong)UITableView * mainTableView;
@property(nonatomic,strong)NSMutableArray * models;
@property(nonatomic,strong)AllSingerModel * model;
@property(nonatomic,retain)NSMutableDictionary *dict;
@property(nonatomic,strong)NSMutableArray * array;
@property(nonatomic,strong)NSMutableArray * hotArray;
@property(nonatomic,strong)NSMutableArray *KeyArray;
@end

static NSString * cell_id = @"cell";
@implementation AllViewController
-(NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}
-(NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
-(NSMutableDictionary *)dict
{
    if (!_dict) {
        _dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

-(NSMutableArray *)hotArray
{
    if (!_hotArray) {
        _hotArray = [NSMutableArray array];
    }
    return _hotArray;
}
-(NSMutableArray *)KeyArray
{
    if (!_KeyArray) {
        _KeyArray = [NSMutableArray array];
    }
    return _KeyArray;
}
-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    }
    return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource  = self;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SingerAnd3DViewCell" bundle:nil] forCellReuseIdentifier:cell_id];
    
    [self downLoadGiftDataFinished:^{
        [self.mainTableView reloadData];
    }];
    
    // Do any additional setup after loading the view.
}

-(void)downLoadGiftDataFinished:(void(^)())result
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [[NSURL alloc]init];
        if (self.index == 0) {
            url=[NSURL URLWithString:AllSingers];
        }else if (self.index == 1){
            url = [NSURL URLWithString:Japan];
        }else if (self.index ==2){
            url = [NSURL URLWithString:American];
        }else if (self.index == 3){
            url = [NSURL URLWithString:Chinese];
        }else if (self.index == 4){
            url = [NSURL URLWithString:Korea];
        }else if (self.index == 5){
            url = [NSURL URLWithString:Other];
        }else if (self.index == 6){
            url = [NSURL URLWithString:Musician];
        }
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary *giftDict = resultDict[@"data"];
            NSArray *giftArray = giftDict[@"artists"];
            NSArray *hot = giftDict[@"hot_artists"];
            for (NSDictionary *dict in giftArray) {
                AllSingerModel *model = [[AllSingerModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.models addObject:model];
            }
            for (NSDictionary *dict in hot) {
                AllSingerModel *model = [[AllSingerModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.hotArray addObject:model];
            }
            for (AllSingerModel *temp in self.models) {
                
            }
//            NSLog(@"%@", self.hotArray);
            [self.KeyArray removeObject:@"#"];
            [self.KeyArray addObject:@"#"];
            
            [self.KeyArray insertObject:@"热门" atIndex:0];
            [self.dict setObject:self.hotArray forKey:@"热门"];
            dispatch_async(dispatch_get_main_queue(), ^{
                result();
            });
        }];
    });
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.KeyArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arrays =[self.dict valueForKey:self.KeyArray[section]];
    return arrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SingerAnd3DViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id forIndexPath:indexPath];
    
    //新建模型并赋值
    NSArray *array2 = [self.dict valueForKey:self.KeyArray[indexPath.section]];
    
    self.model = array2[indexPath.row];
    
    cell.nameLabel.text = self.model.artist_name;
    
    float myInt = [self.model.count_likes floatValue];
    
    if (myInt >= 10000) {
        myInt = myInt /10000 ;
        cell.detailLabel.text = [NSString stringWithFormat:@"%.1lf万粉丝",myInt];
    }else{
        cell.detailLabel.text = [NSString stringWithFormat:@"%@粉丝",self.model.count_likes];
    }
    //剪切图片地址
    NSArray *array = [self.model.artist_logo componentsSeparatedByString:@"@"];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:array.firstObject]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.KeyArray[section];
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
