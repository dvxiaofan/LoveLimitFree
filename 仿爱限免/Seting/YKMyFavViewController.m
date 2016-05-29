//
//  YKMyFavViewController.m
//  仿爱限免
//
//  Created by 小烦 on 16/5/19.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKMyFavViewController.h"
#import "YKScrollPagingView.h"


#define btnWidth 57
#define btnHeight 57

@interface YKMyFavViewController ()<UIScrollViewDelegate,YKScrollPagingViewDelegate>



@end

@implementation YKMyFavViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.titleView = [YKUtility createLabelWithTitle:@"我的收藏"];
    
    self.navigationItem.leftBarButtonItem = [self creatNavBtnWithTitle:@"返回"
                                                             backImage:[UIImage imageNamed:@"buttonbar_back"] action:@selector(actionBack:)];
    self.navigationItem.rightBarButtonItem = [self creatNavBtnWithTitle:@"编辑"
                                                              backImage:[UIImage imageNamed:@"buttonbar_edit"]
                                                                 action:@selector(actionEdit:)];
    
    [self setupScrollView];
    
}

#pragma mark - 创建显示收藏信息的滚动视图

- (void)setupScrollView {
    YKScrollPagingView *spv = [[YKScrollPagingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, SCREEN.height)];
    [spv setImageViewWithTabelName:@"fav"];
    spv.delegate = self;
    [self.view addSubview:spv];
    self.spv = spv;
}

#pragma mark - 构建导航栏按钮

- (UIBarButtonItem *)creatNavBtnWithTitle:(NSString *)title backImage:(UIImage *)image action:(SEL)action {
    
    UIButton *button = [YKUtility createBtnWithTitle:title backgroundImag:image];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] init];
    itme.customView = button;
    
    return itme;
}

#pragma mark - 导航栏按钮点击事件

// 返回按钮
- (void)actionBack:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//编辑
- (void)actionEdit:(UIButton *)button {
    //YKLog(@"edit");
    if (self.isEdit == NO) {
        [self.spv setEditBtn];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        self.isEdit = YES;
    } else {
        [self.spv removeEditBtn];
        //[self.view setNeedsDisplay];
        //[self.view setNeedsLayout];
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        self.isEdit = NO;
    }
    
}

#pragma mark - YKScrollPagingView 代理事件

- (void)scrollPagingViewImageTapIndex:(NSInteger)index {
    YKLog(@"你点击了收藏中的app%ld", (long)index);
}

- (void)editBtnTapIndex:(NSInteger)index {
    YKLog(@"你想编辑%ld个",(long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end











