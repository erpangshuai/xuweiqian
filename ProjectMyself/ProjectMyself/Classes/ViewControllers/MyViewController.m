//
//  MyViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "MyViewController.h"
#import "LocalityViewController.h"
#import "MusicViewController.h"
#import "singLoactionViewController.h"
#import "FindViewController.h"
#import "DenduViewController.h"
#import "Datahandel.h"
#import "DownloadViewController.h"
@interface MyViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *Denlu;

@property (weak, nonatomic) IBOutlet UIButton *touxiangBut;

@property (nonatomic, strong)UIImagePickerController *picker;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.picker = [[UIImagePickerController alloc]init];
    self.picker.delegate = self;
    
    self.touxiangBut.layer.masksToBounds = YES;
    self.touxiangBut.layer.cornerRadius = 30;
    
    // Do any additional setup after loading the view from its nib.
}

//- (void)viewWillAppear:(BOOL)animated {
//    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
//    
//}

//跟换头像
- (IBAction)changetouxiang:(UIButton *)sender {
    if ([Datahandel shareInstance].isLanding == YES) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否从相册选取" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            self.picker.allowsEditing = NO;
            [self presentViewController:self.picker animated:YES completion:nil];
        }];
        UIAlertAction *no = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:self.picker animated:YES completion:nil];
            }else{
                UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"Caution" message:@"Do not find camera, please select from photo!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert1 addAction:okAction];
                [self presentViewController:alert1 animated:YES completion:nil];
            }
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:ok];
        [alert addAction:no];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark --- 第六步：实现协议中的方法
// 已经完成选取图片时执行
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self.touxiangBut setBackgroundImage:[info objectForKey:UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}

// 已经取消选取时执行
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidAppear:(BOOL)animated{
    if ([Datahandel shareInstance].isLanding == YES) {
        [self.Denlu setTitle:@"注销" forState:UIControlStateNormal];
    }else{
        [self.Denlu setTitle:@"登陆/注册" forState:UIControlStateNormal];
    }
}


- (IBAction)denglu:(UIButton *)sender {
    
    if ([Datahandel shareInstance].isLanding == NO) {
        
        DenduViewController *denVC = [[DenduViewController alloc]init];
        [self.navigationController pushViewController:denVC animated:YES];
    }else{
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否注销" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [Datahandel shareInstance].isLanding = NO;
            [self.Denlu setTitle:@"登陆/注册" forState:UIControlStateNormal];
            [self.touxiangBut setBackgroundImage:[UIImage imageNamed:@"24.png"] forState:UIControlStateNormal];
            
        }];
        UIAlertAction *no = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert1 addAction:ok];
        [alert1 addAction:no];
        [self presentViewController:alert1 animated:YES completion:nil];
    }
    
}
//本地歌曲
- (IBAction)BendiGequAction:(UIButton *)sender {
    LocalityViewController *lvc = [[LocalityViewController alloc]init];
    [self.navigationController pushViewController:lvc animated:YES];
    
}


//音乐馆
- (IBAction)MusicAction:(UIButton *)sender {
    MusicViewController *mvc = [[MusicViewController alloc]init];
    [self.navigationController pushViewController:mvc animated:YES];
}

//下载歌曲
- (IBAction)XiazaiMUsic:(UIButton *)sender {
    DownloadViewController *down = [[DownloadViewController alloc]init];
    [self.navigationController pushViewController:down animated:YES];
    
}

//我的最爱
- (IBAction)MYloveAction:(UIButton *)sender {
}

//发现
- (IBAction)FoundAction:(UIButton *)sender {
    FindViewController *findVC = [[FindViewController alloc]init];
    [self.navigationController pushViewController:findVC animated:YES];
}


//我是歌唱家
- (IBAction)signerAction:(UIButton *)sender {
    singLoactionViewController *singVC = [[singLoactionViewController alloc]init];
    [self.navigationController pushViewController:singVC animated:YES];
    
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
