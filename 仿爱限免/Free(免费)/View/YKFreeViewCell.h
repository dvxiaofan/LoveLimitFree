//
//  YKFreeViewCell.h
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/14.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKFreeStatusFrame;

@interface YKFreeViewCell : UITableViewCell

@property (nonatomic, strong) YKStatuses *status;

@property (nonatomic, strong) YKFreeStatusFrame *freeStatusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
