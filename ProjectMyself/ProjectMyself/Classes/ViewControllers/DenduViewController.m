//
//  DenduViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "DenduViewController.h"
#import "ZhuceViewController.h"
#import "MyViewController.h"
#import "Datahandel.h"

@interface DenduViewController ()<UIAlertViewDelegate>

@end

@implementation DenduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.password.secureTextEntry = YES;
    

    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
    image.frame = self.view.bounds;
    image.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:image atIndex:0];
    
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)zhuceClick:(UIButton *)sender {
    ZhuceViewController *mvc = [[ZhuceViewController alloc]init];
    
    [self.navigationController pushViewController:mvc animated:YES];
    
}
//- (void)sendValue:(id)sender1 andValue:(id)sender2{
//    _username.text = sender1;
////    _password.text = sender2;
//}

- (IBAction)dengluClick:(UIButton *)sender {
    if (_username.text.length == 0 || _password.text.length == 0 ) {
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"账号/密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
        [alert1 addAction:ok];
        [self presentViewController:alert1 animated:YES completion:nil];
    } else if (![[NSUserDefaults standardUserDefaults]objectForKey:_username.text]){
        
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"账号不存在" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
        [alert1 addAction:ok];
        [self presentViewController:alert1 animated:YES completion:nil];
    } else if (![[[NSUserDefaults standardUserDefaults]objectForKey:_username.text] isEqualToString:_password.text]){
        
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"密码错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
        [alert1 addAction:ok];
[self presentViewController:alert1 animated:YES completion:nil];
       
    } else {
        [Datahandel shareInstance].isLanding = YES;
        
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"登录成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//            MyViewController *mvc = [[MyViewController alloc]init];
//            [self.navigationController pushViewController:mvc animated:YES];
        
        [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert1 addAction:ok];
        [self presentViewController:alert1 animated:YES completion:nil];
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
