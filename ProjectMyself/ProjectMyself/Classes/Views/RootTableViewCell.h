//
//  RootTableViewCell.h
//  ProjectMyself
//
//  Created by lanou3g on 16/1/30.
//  Copyright © 2016年 徐未钱. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Rootmodel;
@interface RootTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *rootimageview;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *singerlabel;

@property (nonatomic, strong)Rootmodel *model;
@end
