//
//  songListTableViewCell.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "songListTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation songListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setCellDataWithModel:(songListModel *)model{
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.albumCoverUrl290]];
    
    self.titleLabel.text = model.title;
    
    float my = [model.playsCounts floatValue];
    if (my >=10000) {
        my = my/10000;
        self.playsCountsLabel.text = [NSString stringWithFormat:@"%.1lf万",my];
    }else{
        self.playsCountsLabel.text = [NSString stringWithFormat:@"%@",model.playsCounts];
    }
    
    self.tracksLabel.text = [NSString stringWithFormat:@"%@集",model.tracks];
    self.introLabel.text = model.intro;
}

- (void)setCellWithModel:(radioModel *)model{
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.albumCoverUrl290]];
    self.titleLabel.text = model.title;
    
    self.introLabel.text = model.tags;
    
    float my = [model.playsCounts floatValue];
    if (my >=10000) {
        my = my/10000;
        self.playsCountsLabel.text = [NSString stringWithFormat:@"%.1lf万",my];
    }else{
        self.playsCountsLabel.text = [NSString stringWithFormat:@"%@",model.playsCounts];
    }
    
    self.tracksLabel.text = [NSString stringWithFormat:@"%@集", model.tracks];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
