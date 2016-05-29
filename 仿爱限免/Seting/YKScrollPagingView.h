//
//  YKScrollPagingView.h
//  仿爱限免
//
//  Created by 小烦 on 16/5/25.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义一个代理方法
@protocol YKScrollPagingViewDelegate <NSObject>

- (void)scrollPagingViewImageTapIndex:(NSInteger)index;
- (void)editBtnTapIndex:(NSInteger)index;

@end

@interface YKScrollPagingView : UIView

@property (nonatomic, strong) UIButton *appBtn;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *iconUrlArray;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

// 声明代理属性
@property (nonatomic, assign) id <YKScrollPagingViewDelegate> delegate;

- (void)setImageViewWithTabelName:(NSString *)tableName;

- (void)setEditBtn;
- (void)removeEditBtn;
@end
