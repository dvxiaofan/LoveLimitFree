//
//  YKSetViewController.m
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKSetViewController.h"
#import "YKMySetViewController.h"
#import "YKMyFollowViewController.h"
#import "YKMyAccountViewController.h"
#import "YKMyFavViewController.h"
#import "YKMyDownViewController.h"
#import "YKMyHelpViewController.h"
#import "YKCanDouViewController.h"

@interface YKSetViewController ()

@end


#define setBtnWidth 57
#define setBtnHeight 57
#define BTN_BASE_TAG 100

@implementation YKSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = [YKUtility createLabelWithTitle:@"设置详情"];
    
    self.navigationItem.leftBarButtonItem = [self creatNavBtnWithTitle:@"返回"
                                                             backImage:[UIImage imageNamed:@"buttonbar_back"] action:@selector(actionBack:)];
    self.navigationItem.rightBarButtonItem = [self creatNavBtnWithTitle:nil
                                                              backImage:nil
                                                                 action:nil];
    
    [self createSetButton];
    
}

#pragma mark - 创建设置按钮标题label
- (void)createSetButton {
    
    NSArray *imgArray = @[[UIImage imageNamed:@"account_setting"], [UIImage imageNamed:@"account_favorite"], [UIImage imageNamed:@"account_user"], [UIImage imageNamed:@"account_collect"], [UIImage imageNamed:@"account_download"], [UIImage imageNamed:@"account_comment"], [UIImage imageNamed:@"account_help"], [UIImage imageNamed:@"account_candou"]];
    
    NSArray *titleArray = @[@"我的设置", @"我的关注", @"我的账户", @"我的收藏", @"我的下载", @"我的评论", @"我的帮助", @"蚕豆应用"];
    
    // 水平间隔
    CGFloat hFar = (SCREEN.width - setBtnWidth * 3) / (3 + 1);
    // 竖直间隔
    CGFloat vFar = (SCREEN.height - 110 - setBtnHeight * 3) / (3 + 1);
    
    for (int i = 0; i < imgArray.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake((hFar * (i % 3 + 1) + setBtnWidth * (i % 3)), (64 + (vFar * (i / 3 + 1) + setBtnHeight * (i / 3))), setBtnWidth, setBtnHeight);
        [btn setBackgroundImage:imgArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = BTN_BASE_TAG + i;
        
        [self.view addSubview:btn];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake((hFar * (i % 3 + 1) + setBtnWidth * (i % 3)), (64 + (vFar * (i / 3 + 1) + setBtnHeight * (i / 3))) + setBtnHeight + 3, setBtnWidth, 8);
        label.text = titleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11.0];
        
        [self.view addSubview:label];
    }
}

#pragma mark - 设置按钮点击事件
- (void)actionClick:(UIButton *)button {
    NSInteger tag = button.tag;
    switch (tag) {
        case BTN_BASE_TAG:          // 我的设置
        {
            //YKLog(@"点击了 我的设置");
            YKMySetViewController *setVC = [[YKMySetViewController alloc] init];
            [self.navigationController pushViewController:setVC animated:YES];
        }
            break;
        case BTN_BASE_TAG + 1:      // 我的关注
        {
            //YKLog(@"点击了 我的关注");
            YKMyFollowViewController *follVC = [[YKMyFollowViewController alloc] init];
            [self.navigationController pushViewController:follVC animated:YES];
        }
            break;
        case BTN_BASE_TAG + 2:      // 我的账户
        {
            //YKLog(@"点击了 我的账户");
            YKMyAccountViewController *accVC = [[YKMyAccountViewController alloc] init];
            [self.navigationController pushViewController:accVC animated:YES];
        }
            break;
        case BTN_BASE_TAG + 3:      // 我的收藏
        {
            //YKLog(@"点击了 我的收藏");
            YKMyFavViewController *favVC = [[YKMyFavViewController alloc] init];
            [self.navigationController pushViewController:favVC animated:YES];
        }
            break;
        case BTN_BASE_TAG + 4:      // 我的下载
        {
            //YKLog(@"点击了 我的下载");
            YKMyDownViewController *downVC = [[YKMyDownViewController alloc] init];
            [self.navigationController pushViewController:downVC animated:YES];
        }
            break;
        case BTN_BASE_TAG + 5:      // 我的评论
        {
            //YKLog(@"点击了 我的评论");
            // 直接跳转到应用商店的详情页
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_URL]];
        }
            break;
        case BTN_BASE_TAG + 6:      // 我的帮助
        {
            //YKLog(@"点击了 我的帮助");
            YKMyHelpViewController *helpVC = [[YKMyHelpViewController alloc] init];
            helpVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:helpVC animated:YES];
        }
            break;
        case BTN_BASE_TAG + 7:      // 蚕豆应用
        {
            //YKLog(@"点击了 蚕豆应用");
            YKCanDouViewController *candouVC = [[YKCanDouViewController alloc] init];
            [self.navigationController pushViewController:candouVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - 构建导航栏按钮
- (UIBarButtonItem *)creatNavBtnWithTitle:(NSString *)title backImage:(UIImage *)image action:(SEL)action {
    
    UIButton *button = [YKUtility createBtnWithTitle:title backgroundImag:image];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] init];
    itme.customView = button;
    
    return itme;
}
// 返回按钮点击事件
- (void)actionBack:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end














