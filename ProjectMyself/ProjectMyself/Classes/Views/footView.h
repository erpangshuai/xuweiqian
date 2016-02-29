//
//  footView.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface footView : UIView
@property(nonatomic,strong)UIImageView *leadImage;
@property(nonatomic,strong)UILabel *textLabel;
@property(nonatomic,strong)UIButton *rightButton;

-(instancetype)initWithFrame:(CGRect)frame withLeaderImage:(NSString*)leaderImage withTextLabel:(NSString*)textLabel withRightButton:(NSString*)rightButton;

@end
