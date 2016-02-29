//
//  DetailTableViewCell.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellDataWithModel:(detailTableViewModel *)model{
    
    self.titleLabel.text = model.title;
    float myInt = [model.playtimes floatValue];
    
    if (myInt >= 10000) {
        myInt = myInt/10000;
        self.playTimes.text = [NSString stringWithFormat:@"%0.1lf万",myInt];
    }else{
        self.playTimes.text = [NSString stringWithFormat:@"%@", model.playtimes];
    }
    float my = [model.likes floatValue];
    if (my >= 10000) {
        my = my/10000;
        self.likeLabel.text = [NSString stringWithFormat:@"%0.1lf万",my];
    }else{
        self.likeLabel.text = [NSString stringWithFormat:@"%@", model.likes];
    }
    
}

@end
