//
//  MVCollectionViewCell.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "MVCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation MVCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellDataWithModel:(MVModel *)model{
    
    [self.MVimageView  sd_setImageWithURL:[NSURL URLWithString:model.mv_cover]];
    self.titleLabel.text = model.title;
    self.nameLabel.text = model.artist_name;
    
}

@end
