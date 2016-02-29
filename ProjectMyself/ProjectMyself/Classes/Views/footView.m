//
//  footView.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "footView.h"

@implementation footView

-(instancetype)initWithFrame:(CGRect)frame withLeaderImage:(NSString*)leaderImage withTextLabel:(NSString*)textLabel withRightButton:(NSString*)rightButton
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        self.leadImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 11, 8, 10)];
        self.leadImage.image = [UIImage imageNamed:leaderImage];
        //  self.leadImage.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.leadImage];
        
        self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 8, 150, 16)];
        self.textLabel.font = [UIFont systemFontOfSize:13.0f];
        self.textLabel.text = textLabel;
        //  self.textLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.textLabel];
        
        
        self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 44, 8, 35, 12)];
        //  self.rightButton.backgroundColor = [UIColor brownColor];
        [self addSubview:self.rightButton];
        
        UILabel *buttonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 28, 10)];
        // buttonLabel.backgroundColor = [UIColor purpleColor];
        buttonLabel.font = [UIFont systemFontOfSize:13.0f];
        buttonLabel.text = @"更多";
        [self.rightButton addSubview:buttonLabel];
        
        
        UIImageView *buttonImage = [[UIImageView alloc]initWithFrame:CGRectMake(28, 3, 10, 12)];
        // buttonImage.backgroundColor = [UIColor redColor];
        buttonImage.image = [UIImage imageNamed:@"向右"];
        [self.rightButton addSubview:buttonImage];
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
