//
//  YKStatuses.h
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YKStatuses : NSObject

// 字符串型 id
@property (nonatomic, copy) NSString *applicationId;
// 友好显示名称
@property (nonatomic, copy) NSString *name;
// 应用图标地址，57×57像素
@property (nonatomic, copy) NSString *iconUrl;
// 苹果商店
@property (nonatomic, copy) NSString *itunesUrl;
// 到期时间
@property (nonatomic, copy) NSString *expireDatetime;
// 应用所属分组名字
@property (nonatomic, copy) NSString *categoryName;
// 现在状态
@property (nonatomic, copy) NSString *priceTrend;
// 介绍信息
@property (nonatomic, copy) NSString *appDescription;// 自定义，改
// 文件大小
@property (nonatomic, assign) CGFloat fileSize;
// 现价
@property (nonatomic, assign) CGFloat currentPrice;
// 最后的价格
@property (nonatomic, assign) CGFloat lastPrice;
// star 评分
@property (nonatomic, assign) CGFloat starCurrent;
// 	分享数
@property (nonatomic, assign) int shares;
// 收藏数
@property (nonatomic, assign) int favorites;
// 下载数
@property (nonatomic, assign) int downloads;




@end















