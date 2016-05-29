//
//  YKMyHelpViewController.m
//  仿爱限免
//
//  Created by 小烦 on 16/5/19.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKMyHelpViewController.h"

@interface YKMyHelpViewController ()

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger *count;

@end

@implementation YKMyHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.titleView = [YKUtility createLabelWithTitle:@"我的帮助"];
    
    self.navigationItem.leftBarButtonItem = [self creatNavBtnWithTitle:@"返回"
                                                             backImage:[UIImage imageNamed:@"buttonbar_back"] action:@selector(actionBack:)];
    self.navigationItem.rightBarButtonItem = [self creatNavBtnWithTitle:nil
                                                              backImage:nil
                                                                 action:nil];
    
    [self createScrollView];
}

#pragma mark - 创建滚动视图 

- (void)createScrollView {
    NSArray *imageArray = @[[UIImage imageNamed:@"helpphoto_one"], [UIImage imageNamed:@"helpphoto_two"], [UIImage imageNamed:@"helpphoto_three"], [UIImage imageNamed:@"helpphoto_four"], [UIImage imageNamed:@"helpphoto_five"]];
    self.imageArray = imageArray;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    CGFloat scrollViewH = self.view.bounds.size.height - self.tabBarController.tabBar.size.height - 15;
    CGFloat scrollViewX = 5;
    CGFloat scrollViewW = SCREEN.width - 2 * scrollViewX;
    scrollView.frame = CGRectMake(scrollViewX, 0, scrollViewW, scrollViewH);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat imgViewW = scrollView.frame.size.width;
    CGFloat imgViewH = scrollView.frame.size.height;
    for (NSInteger i = 0; i < imageArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        CGFloat imgViewX = i * imgViewW;
        CGFloat imgViewY = 0;
        imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
        imgView.image = imageArray[i];
        [scrollView addSubview:imgView];
    }
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(imgViewW * self.imageArray.count, imgViewH);
    scrollView.bounces = NO;
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
