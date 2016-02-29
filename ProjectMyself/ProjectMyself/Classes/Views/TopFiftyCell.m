//
//  TopFiftyCell.m
//  ProjectMyself
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import "TopFiftyCell.h"

@implementation TopFiftyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatChild];
    }
    return self;
    
}
- (void)creatChild{
    
    self.awardImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 70, 70)];
    // self.backgroundColor = [UIColor redColor];
    [self addSubview:self.awardImage];
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 10, 200, 30)];
    // self.titleLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:self.titleLabel];
    
    
    self.introLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, 200, 20)];
    self.introLabel.font = [UIFont systemFontOfSize:13.0];
    //  self.introLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:self.introLabel];

    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
