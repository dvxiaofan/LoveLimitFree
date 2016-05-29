//
//  YKUtility.m
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/9.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "YKUtility.h"



@implementation YKUtility

+ (UIButton *)createBtnWithTitle:(NSString *)title backgroundImag:(UIImage *)image  {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, navBtnWidth, navBtnHeght);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    
    return btn;
}

+ (UILabel *)createLabelWithTitle:(NSString *)title {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 0, SCREEN.width , 40);
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
    titleLabel.textColor = [UIColor blueColor];
    
    return titleLabel;
}


@end
