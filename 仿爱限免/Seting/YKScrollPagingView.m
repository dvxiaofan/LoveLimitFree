//
//  YKScrollPagingView.m
//  仿爱限免
//
//  Created by 小烦 on 16/5/25.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKScrollPagingView.h"
#import "AppDelegate.h"
#import <UIButton+WebCache.h>


#define btnWidth 57
#define btnHeight 57

#define BUTTON_TAG 100

@interface YKScrollPagingView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *closeBtns;


@end

@implementation YKScrollPagingView

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (NSMutableArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [NSMutableArray array];
    }
    return _nameArray;
}
- (NSMutableArray *)iconUrlArray {
    if (!_iconUrlArray) {
        _iconUrlArray = [NSMutableArray array];
    }
    return _iconUrlArray;
}

- (NSMutableArray *)closeBtns {
    if (!_closeBtns) {
        _closeBtns = [NSMutableArray array];
    }
    return _closeBtns;
}

- (void)setImageViewWithTabelName:(NSString *)tableName {
    // 创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    CGFloat scrollViewH = self.bounds.size.height - 44 - 44 - 20;
    CGFloat scrollViewX = 0;
    CGFloat scrollViewW = SCREEN.width;
    scrollView.frame = CGRectMake(scrollViewX, 0, scrollViewW, scrollViewH);
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    // 根据保存信息显示数据
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    FMDatabase *db = app.db;
    
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tableName];
    FMResultSet *set = [db executeQuery:sql];
    
    while ([set next]) {
        NSString *appName = [set stringForColumn:@"appName"];
        NSString *iconUrl = [set stringForColumn:@"iconUrl"];
        
        [self.nameArray addObject:appName];
        [self.iconUrlArray addObject:iconUrl];
    }
    
    // 水平间隔
    CGFloat hFar = (SCREEN.width - btnWidth * 3) / (3 + 1);
    // 竖直间隔
    CGFloat vFar = (SCREEN.height - 110 - btnHeight * 3) / (3 + 1);
    
    for (NSInteger i = 0; i < _nameArray.count; i++) {
        // 应用图标
        UIButton *appBtn = [[UIButton alloc] init];
        CGFloat btnX = (hFar * (i % 3 + 1) + btnWidth * (i % 3));
        CGFloat btnY = (0 + (vFar * (i / 3 + 1) + btnHeight * (i / 3)));
        appBtn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
        [appBtn sd_setImageWithURL:_iconUrlArray[i] forState:UIControlStateNormal];
        [appBtn addTarget:set action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
        appBtn.layer.cornerRadius = 8;
        appBtn.clipsToBounds = YES;
        appBtn.tag = BUTTON_TAG + i;
        [scrollView addSubview:appBtn];
        self.appBtn = appBtn;
        
        // 应用名字
        UILabel *label = [[UILabel alloc] init];
        label.text = _nameArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:9.0];
        label.textColor = [UIColor blackColor];
        CGFloat labelX = btnX - 5;
        CGFloat labelY = btnY + btnHeight + 4;
        CGFloat labelW = SCREEN.width / 3 - hFar;
        CGFloat labelH = 8;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [scrollView addSubview:label];
    }
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(SCREEN.width * (_nameArray.count / 9 + 1), scrollView.frame.size.height);
    scrollView.bounces = NO;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.userInteractionEnabled = NO;
    pageControl.numberOfPages = _nameArray.count / 9 + 1;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    CGFloat pageWidth = 60;
    CGFloat pageHeigt = 30;
    pageControl.frame = CGRectMake(SCREEN.width / 2 - pageWidth / 2, scrollViewH - 40, pageWidth, pageHeigt);
    [self addSubview:pageControl];
    self.pageControl = pageControl;

}

#pragma mark - 点击图标事件

- (void)actionClick:(UIButton *)button {
    //YKLog(@"你点击收藏的我了");
    // 判断是否实现代理方法
    if ([self.delegate respondsToSelector:@selector(scrollPagingViewImageTapIndex:)]) {
        [self.delegate scrollPagingViewImageTapIndex:button.tag - BUTTON_TAG];
    }
}

#pragma mark - 设置编辑按钮
- (void)setEditBtn {

    // 水平间隔
    CGFloat hFar = (SCREEN.width - btnWidth * 3) / (3 + 1);
    // 竖直间隔
    CGFloat vFar = (SCREEN.height - 110 - btnHeight * 3) / (3 + 1);
    
    for (NSInteger i = 0; i < _nameArray.count; i++) {
        // 应用图标
        UIButton *closeBtn = [[UIButton alloc] init];
        CGFloat btnX = (hFar * (i % 3 + 1) + btnWidth * (i % 3)) - 10;
        CGFloat btnY = (0 + (vFar * (i / 3 + 1) + btnHeight * (i / 3))) - 10;
        closeBtn.frame = CGRectMake(btnX, btnY, 24, 24);
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        closeBtn.tag = BUTTON_TAG + i;
        [self.scrollView addSubview:closeBtn];
        [self.closeBtns addObject:closeBtn];
    }
}

- (void)close:(UIButton *)button {
    //YKLog(@"close");
    
    if ([self.delegate respondsToSelector:@selector(editBtnTapIndex:)]) {
        [self.delegate editBtnTapIndex:button.tag - BUTTON_TAG];
    }
}

#pragma mark - 移除删除标示

- (void)removeEditBtn {
    [self.closeBtns removeAllObjects];
    [self.scrollView reloadInputViews];
}






@end












