//
//  recommendCell.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/23.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "recommendCell.h"

@implementation recommendCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatChild];
    }
    return self;
}

- (void)creatChild{
    
    self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 80, 80)];
    self.iconImage.backgroundColor = [UIColor redColor];
    [self addSubview:self.iconImage];
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, 10, 250, 20)];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:self.titleLabel];
    
    self.introLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, 40, [UIScreen mainScreen].bounds.size.width-135, 20)];
    self.introLabel.textColor = [UIColor grayColor];
    self.introLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.introLabel];
    
    self.userImage = [[UIImageView alloc]initWithFrame:CGRectMake(95, 78, 10, 10)];
    // self.userImage.backgroundColor = [UIColor redColor];
    self.userImage.image = [UIImage imageNamed:@"三角"];
    [self addSubview:self.userImage];
    
    self.userLabel = [[UILabel alloc]initWithFrame:CGRectMake(112, 75, 65, 15)];
    // self.userLabel.backgroundColor = [UIColor blueColor];
    self.userLabel.font = [UIFont systemFontOfSize:10.0f];
    self.userLabel.textColor = [UIColor grayColor];
    [self addSubview:self.userLabel];
    
    self.setImage = [[UIImageView alloc]initWithFrame:CGRectMake(182, 78, 10, 10)];
    // self.setImage.backgroundColor = [UIColor redColor];
    self.setImage.image = [UIImage imageNamed:@"集"];
    [self addSubview:self.setImage];
    
    self.setLabel = [[UILabel alloc]initWithFrame:CGRectMake(202, 75, 65, 15)];
    //  self.setLabel.backgroundColor = [UIColor blueColor];
    self.setLabel.textColor = [UIColor grayColor];
    self.setLabel.font = [UIFont systemFontOfSize:10.0f];
    [self addSubview:self.setLabel];

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
