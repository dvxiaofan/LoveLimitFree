//
//  YKMyFavViewController.h
//  仿爱限免
//
//  Created by 小烦 on 16/5/19.
//  Copyright © 2016年 YK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKScrollPagingView;

@interface YKMyFavViewController : UIViewController

@property (nonatomic, strong) YKScrollPagingView *spv;
@property (nonatomic, assign) BOOL isEdit;

@end
