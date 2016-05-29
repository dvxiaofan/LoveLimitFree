//
//  AppDelegate.m
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "AppDelegate.h"
#import "YKRootViewController.h"
#import "YKLimitViewController.h"
#import "YKSaleViewController.h"
#import "YKFreeViewController.h"
#import "YKSpecialViewController.h"
#import "YKHotViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - 初始化视图控制器
- (void)initViewController {
    
    YKLimitViewController *limitVC = [[YKLimitViewController alloc] init];
    YKSaleViewController *saleVC = [[YKSaleViewController alloc] init];
    YKFreeViewController *freeVC = [[YKFreeViewController alloc] init];
    YKSpecialViewController *speVC = [[YKSpecialViewController alloc] init];
    YKHotViewController *hotVC = [[YKHotViewController alloc] init];
    
    NSArray *vcArray = @[limitVC, saleVC, freeVC, speVC, hotVC];
    
    // 构建可变数组保存标签控制器控制的导航控制器
    NSMutableArray *tabArray = [[NSMutableArray alloc] initWithCapacity:vcArray.count];
    
    // 构建导航控制器
    for (int i = 0; i < vcArray.count; i++) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vcArray[i]];
        
        [tabArray addObject:nav];
    }
    
    UITabBarController *tbc = [[UITabBarController alloc] init];
    tbc.viewControllers = tabArray;
    
    self.window.rootViewController = tbc;
}

#pragma mark - application 事件
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    YKRootViewController *rootVC = [[YKRootViewController alloc] init];
    self.window.rootViewController = rootVC;
    
    // 设置启动图片渐渐消失效果
    NSArray *imageArray = @[[UIImage imageNamed:@"Default1"], [UIImage imageNamed:@"Default2"], [UIImage imageNamed:@"Default3"]];
    NSInteger imgIndex = arc4random() % imageArray.count;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    imgView.image = imageArray[imgIndex]; // 图片随机
    
    [rootVC.view addSubview:imgView];
    // 动画
    [UIView animateWithDuration:2 animations:^{
        imgView.alpha = 0;
    } completion:nil];
    
    // 创建数据库文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths firstObject];
    docPath = [docPath stringByAppendingPathComponent:@"app.db"];
    _db = [[FMDatabase alloc] initWithPath:docPath];
    YKLog(@"path = %@", docPath);
    
    // 打开数据库
    _bl = [_db open];
    if (!_bl) {
        YKLog(@"打开数据库失败");
    }
    // 操作数据库 先创建表 create table if not exists message(User text,username text,time text,msg text,flat int,me text)
    _bl = [_db executeUpdate:@"create table if not exists fav(appName text,iconUrl text)"];
    if (!_bl) {
        YKLog(@"创建收藏信息表失败");
    }
    _bl = [_db executeUpdate:@"create table if not exists down(appName text,iconUrl text)"];
    if (!_bl) {
        YKLog(@"创建下载信息表失败");
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
