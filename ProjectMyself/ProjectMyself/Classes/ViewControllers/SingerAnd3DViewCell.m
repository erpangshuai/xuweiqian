//
//  SingerAnd3DViewCell.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/28.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "SingerAnd3DViewCell.h"

@implementation SingerAnd3DViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.iconImage.layer.cornerRadius = 50;
    self.iconImage.clipsToBounds = YES;
    // Configure the view for the selected state
}

@end
