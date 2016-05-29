//
//  YKStatusFrame.h
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/13.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKStatusFrame : NSObject

@property (nonatomic, strong) YKStatuses *status;

// 应用整体
@property (nonatomic, assign) CGRect originalFrame;

// 图标
@property (nonatomic, assign) CGRect iconFrame;

//名字
@property (nonatomic, assign) CGRect nameFrame;

//到期时间
@property (nonatomic, assign) CGRect timeFrame;

// 应用所属分组名字
@property (nonatomic, assign) CGRect categoryNameFrame;

// 最后的价格
@property (nonatomic, assign) CGRect lastPriceFrame;

//星星
@property (nonatomic, assign) CGRect starFrame;

//底部信息
@property (nonatomic, assign) CGRect bottomFrame;

//cell高度 公开是因为其他类要用
@property (nonatomic, assign) CGFloat cellHeight;

@end
