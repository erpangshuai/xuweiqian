//
//  DetailTableViewCell.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/25.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailTableViewModel.h"

@interface DetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimes;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;


#pragma mark - cell的赋值方法
-(void)setCellDataWithModel:(detailTableViewModel *)model;
@end
