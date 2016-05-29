//
//  AppDelegate.h
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, assign) BOOL bl;

@end

