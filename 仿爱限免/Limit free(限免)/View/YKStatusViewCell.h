//
//  YKStatusViewCell.h
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/13.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKStatusFrame;

@interface YKStatusViewCell : UITableViewCell

@property (nonatomic, strong) YKStatuses *status;

@property (nonatomic, strong) YKStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end



