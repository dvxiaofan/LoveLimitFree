//
//  YKStatusViewCell.m
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/13.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKStatusViewCell.h"
#import "YKStatusFrame.h"

@interface YKStatusViewCell()

// 整体
@property (nonatomic, weak) UIView *originalView;
// 图标
@property (nonatomic, weak) YKIconView *iconView;
// 名字
@property (nonatomic, weak) UILabel *nameLabel;
// 时间
@property (nonatomic, weak) UILabel *timeLabel;
// 星星
@property (nonatomic, weak) YKStarView *starView;
//最后价格
@property (nonatomic, weak) UILabel *lastPriceLabel;
//应用分组
@property (nonatomic, weak) UILabel *cateNameLabel;
// 底部信息
@property (nonatomic, weak) UILabel *bottomLabel;

@end

@implementation YKStatusViewCell

/**
 *  自定义单元格
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"status";
    YKStatusViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YKStatusViewCell alloc]
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
    
    //图标
    YKIconView *iconView = [[YKIconView alloc] init];
    [originalView addSubview:iconView];
    iconView.layer.cornerRadius = 8;
    self.iconView = iconView;
    
    //名字
    UILabel *nameLabel = [[UILabel alloc] init];
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //时间
    UILabel *timeLabel = [[UILabel alloc] init];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    //星星
    YKStarView *starView = [[YKStarView alloc] init];
    [originalView addSubview:starView];
    self.starView = starView;
    
    // 最后价格
    UILabel *lastPriceLabel = [[UILabel alloc] init];
    [originalView addSubview:lastPriceLabel];
    self.lastPriceLabel = lastPriceLabel;
    
    //应用分组
    UILabel *cateNameLabel = [[UILabel alloc] init];
    [originalView addSubview:cateNameLabel];
    self.cateNameLabel = cateNameLabel;
    //YKStatuses *status = _statusFrame.status;
    //if ([self.status.categoryName isEqualToString:@"Game"]) {
        //self.cateNameLabel.text = @"类型:游戏";
    //}
    
    //底部信息
    UILabel *bottomLabel = [[UILabel alloc] init];
    [originalView addSubview:bottomLabel];
    self.bottomLabel = bottomLabel;
}

#pragma mark -  给每个元素设置frame
- (void)setStatusFrame:(YKStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    YKStatuses *status = statusFrame.status;
    
    
    // 整体
    self.originalView.frame = statusFrame.originalFrame;
    
    //图标
    self.iconView.frame = statusFrame.iconFrame;
    self.iconView.status = status;
    
    //名字
    self.nameLabel.frame = statusFrame.nameFrame;
    self.nameLabel.text = status.name;
    self.nameLabel.font = YKStatusCellNameFont;
    self.nameLabel.textColor = YKStatusCellNameColor;
    
    //时间
    self.timeLabel.frame = statusFrame.timeFrame;
    self.timeLabel.font = YKStatusCellTextFont;
    self.timeLabel.textColor = YKStatusCellTextColor;
    
    NSDate *nowDate = [NSDate date];
    // 创建日期格式化格式
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    
    // 获得剩余截止时间数据
    
    // 截止时间字符串格式
    NSString *expireDateStr = status.expireDatetime;
    // 当前时间字符串格式
    NSString *nowDateStr = [dateFomatter stringFromDate:nowDate];
    // 截止时间data格式
    NSDate *expireDate = [dateFomatter dateFromString:expireDateStr];
    // 当前时间data格式
    nowDate = [dateFomatter dateFromString:nowDateStr];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:0];
    // 设置显示时间
    self.timeLabel.text = [NSString stringWithFormat:@"剩余:%ld:%ld:%ld", (long)dateCom.hour, (long)dateCom.minute, (long)dateCom.second];
    
    //星星
    self.starView.frame = statusFrame.starFrame;
    self.starView.showStar = status.starCurrent * 20;
    
    // 最后价格
    self.lastPriceLabel.frame = statusFrame.lastPriceFrame;
    self.lastPriceLabel.text = [NSString stringWithFormat:@"%.1f", status.lastPrice];
    self.lastPriceLabel.textAlignment = NSTextAlignmentCenter;
    self.lastPriceLabel.font = YKStatusCellTextFont;
    self.lastPriceLabel.textColor = YKStatusCellTextColor;
    // 给价格加横线
    NSMutableAttributedString *marketPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",self.lastPriceLabel.text]];
    [marketPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, marketPrice.length)];
    self.lastPriceLabel.attributedText = marketPrice;
    //YKLog(@"lastprice = %@", self.lastPriceLabel.text);
    
    //应用分组
    self.cateNameLabel.frame = statusFrame.categoryNameFrame;
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
    self.cateNameLabel.font = YKStatusCellTextFont;
    self.cateNameLabel.textColor = YKStatusCellTextColor;
    
    //底部信息
    self.bottomLabel.frame = statusFrame.bottomFrame;
    self.bottomLabel.text = [NSString stringWithFormat:@"分享 : %d次 收藏 : %d次 下载 : %d次",status.shares, status.favorites, status.downloads];
    self.bottomLabel.font = YKStatusCellTextFont;
    self.bottomLabel.textColor = YKStatusCellTextColor;
    self.bottomLabel.textAlignment = NSTextAlignmentLeft;
    //YKLog(@"bottomLabel=%@", status.itunesUrl);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
