//
//  YKIconView.m
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKIconView.h"




@implementation YKIconView


- (void)setStatus:(YKStatuses *)status {
    _status = status;
    
    [self sd_setImageWithURL:[NSURL URLWithString:status.iconUrl] placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];
}


@end














