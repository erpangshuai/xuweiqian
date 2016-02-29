//
//  ZhuceViewController.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol sendValueDelegate <NSObject>
//
//- (void)sendValue:(id)sender1 andValue:(id)sender2;
//
//@end
@interface ZhuceViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *password2;
//@property (nonatomic, assign)id<sendValueDelegate>delegate;


@end
