//
//  songListTableViewCell.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "songListModel.h"
#import "radioModel.h"
@interface songListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *playsCountsLabel;
@property (weak, nonatomic) IBOutlet UILabel *tracksLabel;


#pragma mark - cell的赋值方法
-(void)setCellDataWithModel:(songListModel *)model;

#pragma mark - cell的赋值方法
-(void)setCellWithModel:(radioModel *)model;


@end
