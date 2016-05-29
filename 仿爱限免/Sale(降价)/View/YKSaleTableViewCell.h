//
//  YKSaleTableViewCell.h
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/14.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKSaleStatusFrame;

@interface YKSaleTableViewCell : UITableViewCell

@property (nonatomic, strong) YKStatuses *status;

@property (nonatomic, strong) YKSaleStatusFrame *saleStatusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
