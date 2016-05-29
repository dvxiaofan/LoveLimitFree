//
//  YKRootViewController.m
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKRootViewController.h"
#import "YKLimitViewController.h"
#import "YKSaleViewController.h"
#import "YKFreeViewController.h"
#import "YKSpecialViewController.h"
#import "YKHotViewController.h"

@interface YKRootViewController ()

@end

@implementation YKRootViewController

@synthesize tabBarView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViewController];
}

#pragma mark - 初始化视图控制器
- (void)initViewController {
    
    YKLimitViewController *limitVC = [[YKLimitViewController alloc] init];
    limitVC.tabBarItem.title = @"限免";
    limitVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_limitfree"];
    
    YKSaleViewController *saleVC = [[YKSaleViewController alloc] init];
    saleVC.tabBarItem.title = @"降价";
    saleVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_reduceprice"];
    
    YKFreeViewController *freeVC = [[YKFreeViewController alloc] init];
    freeVC.tabBarItem.title = @"免费";
    freeVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_appfree"];
    
    YKSpecialViewController *speVC = [[YKSpecialViewController alloc] init];
    speVC.tabBarItem.title = @"专题";
    speVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_subject"];
    
    YKHotViewController *hotVC = [[YKHotViewController alloc] init];
    hotVC.tabBarItem.title = @"热榜";
    hotVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_rank"];
    
    NSArray *vcArray = @[limitVC, saleVC, freeVC, speVC, hotVC];
    
    // 构建可变数组保存标签控制器控制的导航控制器
    NSMutableArray *tabArray = [[NSMutableArray alloc] initWithCapacity:vcArray.count];
    
    // 构建导航控制器
    for (int i = 0; i < vcArray.count; i++) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vcArray[i]];
        
        [tabArray addObject:nav];
    }
    
    self.viewControllers = tabArray;
    
}





@end











