//
//  YKSaleTableViewCell.m
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/14.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKSaleTableViewCell.h"
#import "YKSaleStatusFrame.h"


@interface YKSaleTableViewCell ()

// 整体
@property (nonatomic, weak) UIView *originalView;
// 图标
@property (nonatomic, weak) YKIconView *iconView;
// 名字
@property (nonatomic, weak) UILabel *nameLabel;
// 现价
@property (nonatomic, weak) UILabel *currentPriceLabel;
// 星星
@property (nonatomic, weak) YKStarView *starView;
//最后价格
@property (nonatomic, weak) UILabel *lastPriceLabel;
//应用分组
@property (nonatomic, weak) UILabel *cateNameLabel;
// 底部信息
@property (nonatomic, weak) UILabel *bottomLabel;

@end


@implementation YKSaleTableViewCell


/**
 *  自定义单元格
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"status";
    YKSaleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YKSaleTableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  自定义单元格初始化方法，一个单元格只会调用一次
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // 点击cell不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 初始化整体
        [self initOriginal];
    }
    
    return self;
}

#pragma mark - 初始化整体方法
- (void)initOriginal {
    // 整体
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    // 图标
    YKIconView *iconView = [[YKIconView alloc] init];
    [originalView addSubview:iconView];
    iconView.layer.cornerRadius = 8;
    self.iconView = iconView;
    
    // 名字
    UILabel *nameLabel = [[UILabel alloc] init];
    [originalView addSubview:nameLabel];
    nameLabel.font = YKStatusCellNameFont;
    nameLabel.textColor = YKStatusCellNameColor;
    self.nameLabel = nameLabel;
    
    // 现价
    UILabel *currentPriceLabel = [[UILabel alloc] init];
    [originalView addSubview:currentPriceLabel];
    currentPriceLabel.font = YKStatusCellTextFont;
    currentPriceLabel.textColor = YKStatusCellTextColor;
    self.currentPriceLabel = currentPriceLabel;
    
    // 星星
    YKStarView *starView = [[YKStarView alloc] init];
    [originalView addSubview:starView];
    self.starView = starView;
    
    // 最后价格
    UILabel *lastPriceLabel = [[UILabel alloc] init];
    [originalView addSubview:lastPriceLabel];
    lastPriceLabel.font = YKStatusCellTextFont;
    lastPriceLabel.textColor = YKStatusCellTextColor;
    self.lastPriceLabel = lastPriceLabel;
    
    //应用分组
    UILabel *cateNameLabel = [[UILabel alloc] init];
    [originalView addSubview:cateNameLabel];
    cateNameLabel.font = YKStatusCellTextFont;
    cateNameLabel.textColor = YKStatusCellTextColor;
    self.cateNameLabel = cateNameLabel;
    
    //底部信息
    UILabel *bottomLabel = [[UILabel alloc] init];
    [originalView addSubview:bottomLabel];
    bottomLabel.font = YKStatusCellTextFont;
    bottomLabel.textColor = YKStatusCellTextColor;
    bottomLabel.textAlignment = NSTextAlignmentLeft;
    self.bottomLabel = bottomLabel;
}

#pragma mark -  给每个元素设置frame
- (void)setSaleStatusFrame:(YKSaleStatusFrame *)saleStatusFrame {
    _saleStatusFrame = saleStatusFrame;
    YKStatuses *status = saleStatusFrame.status;
    
    // 整体
    self.originalView.frame = saleStatusFrame.originalFrame;
    
    // 图标
    self.iconView.frame = saleStatusFrame.iconFrame;
    self.iconView.status = status;
    
    // 名字
    self.nameLabel.frame = saleStatusFrame.nameFrame;
    self.nameLabel.text = status.name;
    
    // 现价
    self.currentPriceLabel.frame = saleStatusFrame.currentPriceFrame;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"现价:￥%f", status.currentPrice];
    
    //YKLog(@"price = %@", self.currentPriceLabel.text);
    
    //星星
    self.starView.frame = saleStatusFrame.starFrame;
    self.starView.showStar = status.starCurrent * 20;
    
    // 最后价格
    self.lastPriceLabel.frame = saleStatusFrame.lastPriceFrame;
    self.lastPriceLabel.text = [NSString stringWithFormat:@"%.1f", status.lastPrice];
    self.lastPriceLabel.textAlignment = NSTextAlignmentCenter;
    // 给价格加横线
    NSMutableAttributedString *marketPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",self.lastPriceLabel.text]];
    [marketPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, marketPrice.length)];
    self.lastPriceLabel.attributedText = marketPrice;
    //YKLog(@"lastprice = %@", self.lastPriceLabel.text);
    
    //应用分组
    self.cateNameLabel.frame = saleStatusFrame.categoryNameFrame;
    if ([status.categoryName isEqualToString:@"Game"]) {
        self.cateNameLabel.text = @"游戏";
    }
    else if ([status.categoryName isEqualToString:@"Pastime"]) {
        self.cateNameLabel.text = @"娱乐";
    }
    else if ([status.categoryName isEqualToString:@"Education"]) {
        self.cateNameLabel.text = @"教育";
    }
    else if ([status.categoryName isEqualToString:@"Tool"]) {
        self.cateNameLabel.text = @"工具";
    }
    else if ([status.categoryName isEqualToString:@"Photography"]) {
        self.cateNameLabel.text = @"摄影";
    }
    else if ([status.categoryName isEqualToString:@"Ability"]) {
        self.cateNameLabel.text = @"效率";
    }
    else if ([status.categoryName isEqualToString:@"Weather"]) {
        self.cateNameLabel.text = @"天气";
    }
    else if ([status.categoryName isEqualToString:@"Music"]) {
        self.cateNameLabel.text = @"音乐";
    }
    self.cateNameLabel.textAlignment = NSTextAlignmentCenter;
    
    //底部信息
    self.bottomLabel.frame = saleStatusFrame.bottomFrame;
    self.bottomLabel.text = [NSString stringWithFormat:@"分享 : %d次 收藏 : %d次 下载 : %d次",status.shares, status.favorites, status.downloads];
    //YKLog(@"%@", self.bottomLabel.text);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
