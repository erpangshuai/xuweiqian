//
//  RootViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/30.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "RootViewController.h"
#import "RootTableViewCell.h"
#import "Rootmodel.h"
#import "RootRequestManager.h"
#import "RootTableViewCell.h"
#import "UIImageView+WebCache.h"
#define kMusicUrl @"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist"
static NSString *reuseIdenti = @"list";
@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *listTableView;



@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自动为滚动视图添加属性关闭
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置为不透明
    self.navigationController.navigationBar.translucent = NO;
    //初始化tableView
    self.listTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:self.listTableView];
    //设置代理
    self.listTableView.dataSource = self;
    self.listTableView.delegate = self;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = self.view.bounds;
    imageView.image = [UIImage imageNamed:@"1.jpg"];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    self.listTableView.backgroundColor = [UIColor clearColor];
    //    [self.listTableView insertSubview:imageView atIndex:0];
    [self.listTableView setBackgroundView:imageView];

    [self.listTableView registerNib:[UINib nibWithNibName:@"RootTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdenti];
    
    [[RootRequestManager shareInstance]requestWithUrl:kMusicUrl didFinish:^{
        [self.listTableView reloadData];
    }];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[RootRequestManager shareInstance]countofArray];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdenti forIndexPath:indexPath];
    
    cell.model = [[RootRequestManager shareInstance]modelWithIndex:indexPath.row];
    [cell.rootimageview sd_setImageWithURL:[NSURL URLWithString:cell.model.picUrl]];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
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
