//
//  MVCollectionViewCell.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/26.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVModel.h"
@interface MVCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *MVimageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

#pragma mark - cell的赋值方法
-(void)setCellDataWithModel:(MVModel *)model;

@end
