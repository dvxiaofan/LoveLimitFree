//
//  YKFreeViewCell.m
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/14.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKFreeViewCell.h"
#import "YKFreeStatusFrame.h"



@interface YKFreeViewCell ()

// 整体
@property (nonatomic, weak) UIView *originalView;
//图标
@property (nonatomic, weak) YKIconView *iconView;
//名字
@property (nonatomic, weak) UILabel *nameLabel;
//评分
@property (nonatomic, weak) UILabel *evaluLabel;
//星星
@property (nonatomic, weak) YKStarView *starView;
//最后价格
@property (nonatomic, weak) UILabel *lastPticeLabel;
//分类
@property (nonatomic, weak) UILabel *cataLabel;
//底部信息
@property (nonatomic, weak) UILabel *bottomLabel;

@end


@implementation YKFreeViewCell

/**
 *  自定义单元格
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"status";
    YKFreeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YKFreeViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 初始化整体
        [self initOriginal];
    }
    
    return self;
}

#pragma mark - 初始化整体方法
- (void)initOriginal {
    
    // 整体
    UIView  *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    //图标
    YKIconView *iconView = [[YKIconView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    //名字
    UILabel *nameLabel = [[UILabel alloc] init];
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //评分
    UILabel *evaluLabel = [[UILabel alloc] init];
    [originalView addSubview:evaluLabel];
    self.evaluLabel = evaluLabel;
    
    //星星
    YKStarView *starView = [[YKStarView alloc] init];
    [originalView addSubview:starView];
    self.starView = starView;
    
    //最后价格
    UILabel *lastPriceLabel = [[UILabel alloc] init];
    [originalView addSubview:lastPriceLabel];
    self.lastPticeLabel = lastPriceLabel;
    
    //分组
    UILabel *cateLabel = [[UILabel alloc] init];
    [originalView addSubview:cateLabel];
    self.cataLabel = cateLabel;
    
    //底部信息
    UILabel *bottomLabel = [[UILabel alloc] init];
    [originalView addSubview:bottomLabel];
    self.bottomLabel = bottomLabel;
}

#pragma mark -  给每个元素设置frame
- (void)setFreeStatusFrame:(YKFreeStatusFrame *)freeStatusFrame {
    _freeStatusFrame = freeStatusFrame;
    YKStatuses *status = freeStatusFrame.status;
    
    // 整体
    self.originalView.frame = freeStatusFrame.originalFrame;
    
    //图标
    self.iconView.frame = freeStatusFrame.iconFrame;
    self.iconView.status = status;
    self.iconView.layer.cornerRadius = 8.0;
    
    //名字
    self.nameLabel.frame = freeStatusFrame.nameFrame;
    self.nameLabel.text = status.name;
    self.nameLabel.font = YKStatusCellNameFont;
    self.nameLabel.textColor = YKStatusCellNameColor;
    
    //评分
    self.evaluLabel.frame = freeStatusFrame.evaluFrame;
    self.evaluLabel.text = [NSString stringWithFormat:@"评分:%.1f分", status.starCurrent];
    self.evaluLabel.font = YKStatusCellTextFont;
    self.evaluLabel.textColor = YKStatusCellTextColor;
    
    //星星
    self.starView.frame = freeStatusFrame.starFrame;
    self.starView.showStar = status.starCurrent * 20;
    
    //最后价格
    self.lastPticeLabel.frame = freeStatusFrame.lastPriceFrame;
    self.lastPticeLabel.text = [NSString stringWithFormat:@"￥%.1f", status.lastPrice];
    self.lastPticeLabel.font = YKStatusCellTextFont;
    self.lastPticeLabel.textColor = YKStatusCellTextColor;
    
    //分类
    self.cataLabel.frame = freeStatusFrame.categoryNameFrame;
    if ([status.categoryName isEqualToString:@"Game"]) {
        self.cataLabel.text = @"游戏";
    }
    else if ([status.categoryName isEqualToString:@"Pastime"]) {
        self.cataLabel.text = @"娱乐";
    }
    else if ([status.categoryName isEqualToString:@"Education"]) {
        self.cataLabel.text = @"教育";
    }
    else if ([status.categoryName isEqualToString:@"Tool"]) {
        self.cataLabel.text = @"工具";
    }
    else if ([status.categoryName isEqualToString:@"Photography"]) {
        self.cataLabel.text = @"摄影";
    }
    else if ([status.categoryName isEqualToString:@"Ability"]) {
        self.cataLabel.text = @"效率";
    }
    else if ([status.categoryName isEqualToString:@"Weather"]) {
        self.cataLabel.text = @"天气";
    }
    else if ([status.categoryName isEqualToString:@"Music"]) {
        self.cataLabel.text = @"音乐";
    }
    self.cataLabel.textAlignment = NSTextAlignmentCenter;
    self.cataLabel.font = YKStatusCellTextFont;
    self.cataLabel.textColor = YKStatusCellTextColor;
    
    //底部信息
    self.bottomLabel.frame = freeStatusFrame.bottomFrame;
    self.bottomLabel.text = [NSString stringWithFormat:@"分享 : %d次 收藏 : %d次 下载 : %d次",status.shares, status.favorites, status.downloads];
    self.bottomLabel.textAlignment = NSTextAlignmentLeft;
    self.bottomLabel.font = YKStatusCellTextFont;
    self.bottomLabel.textColor = YKStatusCellTextColor;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
