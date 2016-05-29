//
//  YKMyAccountViewController.m
//  仿爱限免
//
//  Created by 小烦 on 16/5/19.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKMyAccountViewController.h"

@interface YKMyAccountViewController ()

@end

@implementation YKMyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.titleView = [YKUtility createLabelWithTitle:@"我的账户"];
    
    self.navigationItem.leftBarButtonItem = [self creatNavBtnWithTitle:@"返回"
                                                             backImage:[UIImage imageNamed:@"buttonbar_back"] action:@selector(actionBack:)];
    self.navigationItem.rightBarButtonItem = [self creatNavBtnWithTitle:nil
                                                              backImage:nil
                                                                 action:nil];
    
    [self createImageView];
}

#pragma mark - 创建imageView 
- (void)createImageView {
    // 整体
    UIImageView *originalImgView = [[UIImageView alloc] init];
    CGFloat imageViewX = 6;
    CGFloat imageViewY = 10;
    CGFloat imageViewW = SCREEN.width - imageViewX * 2;
    CGFloat imageViewH = 240;//SCREEN.height / 2;
    originalImgView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [self.view addSubview:originalImgView];
    originalImgView.image = [UIImage imageNamed:@"user_background"];
    
    YKLog(@"h = %.1f", imageViewH);
    
    // 账户信息Label
    UILabel *accountLabel = [[UILabel alloc] init];
    CGFloat accLabelW = 100;
    CGFloat accLabelH = 33;
    CGFloat accLabelX = imageViewX + 13;
    CGFloat accLabelY = imageViewY + accLabelH;
    accountLabel.frame = CGRectMake(accLabelX, accLabelY, accLabelW, accLabelH);
    accountLabel.text = @"账户信息";
    accountLabel.font = [UIFont systemFontOfSize:16];
    accountLabel.textColor = [UIColor whiteColor];
    [originalImgView addSubview:accountLabel];
    
    // 详细信息
    NSArray *imgArray = @[[UIImage imageNamed:@"user_download"], [UIImage imageNamed:@"user_browse"], [UIImage imageNamed:@"user_total"]];
    NSString *downStr = @"你下载了 6 款应用节省了 ￥79.00";
    NSString *lookStr = @"你浏览了 91 款应用总计 ￥953.00";
    NSString *totalStr = @"当前限免52520款应用总计￥888888";
    NSArray *infoArray = @[downStr, lookStr, totalStr];
    
    for (NSInteger i =0; i <imgArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        CGFloat imgViewWH = 23.0;
        CGFloat imgViewX = accLabelX;
        CGFloat imgViewY = CGRectGetMaxY(accountLabel.frame) + 25 + imgViewWH * 2 * i;
        imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewWH, imgViewWH);
        imgView.image = imgArray[i];
        [originalImgView addSubview:imgView];
        
        UILabel *infoLablel = [[UILabel alloc] init];
        infoLablel.text = infoArray[i];
        infoLablel.font = [UIFont systemFontOfSize:14.0];
        infoLablel.textColor = [UIColor grayColor];
        CGFloat infoX = CGRectGetMaxX(imgView.frame) + 10;
        CGFloat infoY = imgViewY + 2;
        CGSize infoSize = [infoLablel.text sizeWithFont:infoLablel.font];
        infoLablel.frame = CGRectMake(infoX, infoY, infoSize.width, infoSize.height);
        [originalImgView addSubview:infoLablel];
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

#pragma mark - 导航栏按钮点击事件
// 返回按钮
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
