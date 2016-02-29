//
//  ZhuceViewController.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "ZhuceViewController.h"


@interface ZhuceViewController ()<UIAlertViewDelegate>

@end

@implementation ZhuceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    self.password1.secureTextEntry = YES;
    self.password2.secureTextEntry = YES;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"3.jpg"]];
    image.frame = self.view.bounds;
    image.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:image atIndex:0];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)zhuceAction:(UIButton *)sender {
    if (_username.text.length == 0||_password1.text.length == 0||_password2.text.length == 0) {
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"请填写完整" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert1 addAction:ok];
        [self presentViewController:alert1 animated:YES completion:nil];

    }else{
        if (![_password1.text isEqualToString:_password2.text]) {
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"两次输入的密码不一致" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert1 addAction:ok];
            [self presentViewController:alert1 animated:YES completion:nil];
    }else{
            if ([[NSUserDefaults standardUserDefaults] objectForKey:_username.text]) {
               
                UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"该用户已存在" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert1 addAction:ok];
                [self presentViewController:alert1 animated:YES completion:nil];
            
            }else{
                
                [[NSUserDefaults standardUserDefaults]setObject:_password1.text forKey:_username.text];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"注册成功"  message:@"欢迎登陆"preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert1 addAction:ok];
                [self presentViewController:alert1 animated:YES completion:nil];

            }
        }
    }
    
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    [self.delegate sendValue:_username.text andValue:_password1.text];
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (IBAction)quxiaoAction:(UIButton *)sender {
    
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
