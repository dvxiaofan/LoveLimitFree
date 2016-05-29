//
//  YKFreeStatusFrame.m
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/14.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKFreeStatusFrame.h"

@implementation YKFreeStatusFrame

- (void)setStatus:(YKStatuses *)status {
    _status = status;
    
    
    // cell 的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    // 图标
    CGFloat iconWH = 57;
    CGFloat iconX = YKStatusCellBorderW;
    CGFloat iconY = YKStatusCellBorderH;
    self.iconFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    // 名字
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + YKStatusCellBorderW;
    CGFloat nameY = YKStatusCellBorderH - 5;
    CGFloat nameW = cellWidth - iconWH;
    CGFloat nameH = YKStarHeight;
    self.nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //YKLog(@"nameY = %f", nameX);
    
    // 现价
    CGFloat evaluX = nameX;
    CGFloat evaluY = CGRectGetMaxY(self.nameFrame) + 3;
    CGFloat evaluW = YKStarWidth;
    CGFloat evaluH = YKStarHeight;
    self.evaluFrame = CGRectMake(evaluX, evaluY, evaluW, evaluH);
    
    // 星星
    CGFloat starX = nameX;
    CGFloat starY = CGRectGetMaxY(self.evaluFrame) + 3;
    CGFloat starW = YKStarWidth;
    CGFloat starH = evaluH;
    self.starFrame = CGRectMake(starX, starY, starW, starH);
    
    // 最后价格
    CGFloat lastPriceX = cellWidth - 100;
    CGFloat lastPriceY = evaluY;
    CGFloat lastPriceW = 50;
    CGFloat lastPriceH = evaluH;
    self.lastPriceFrame = CGRectMake(lastPriceX, lastPriceY, lastPriceW, lastPriceH);
    
    // 应用分组
    CGFloat cateNameX = lastPriceX;
    CGFloat cateNameY = starY;
    CGFloat cateNameW = lastPriceW;
    CGFloat cateNameH = evaluH;
    self.categoryNameFrame = CGRectMake(cateNameX, cateNameY, cateNameW, cateNameH);
    
    // 底部信息条
    CGFloat bottomX = iconX;
    CGFloat bottomY = CGRectGetMaxY(self.iconFrame) + 4;
    CGFloat bottomW = cellWidth;
    CGFloat bottomH = 22;
    self.bottomFrame = CGRectMake(bottomX, bottomY, bottomW, bottomH);
    
    // 整体
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellWidth;
    CGFloat originalH = CGRectGetMaxY(self.bottomFrame) + 5;
    self.originalFrame = CGRectMake(originalX, originalY, originalW, originalH);
    
    // cell 的高度
    self.cellHeight = originalH;
}

@end
