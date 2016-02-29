//
//  RootTableViewCell.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/30.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "RootTableViewCell.h"
#import "Rootmodel.h"
@implementation RootTableViewCell

- (void)setModel:(Rootmodel *)model{
    if (model) {
        _model = model;
    }
    self.namelabel.text = model.name;
    self.singerlabel.text = model.singer;
    self.rootimageview.layer.masksToBounds = YES;
    self.rootimageview.layer.cornerRadius = (self.bounds.size.height - 10) / 2;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
