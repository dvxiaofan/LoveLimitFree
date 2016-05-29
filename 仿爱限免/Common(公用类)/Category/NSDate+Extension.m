//
//  NSDate+Extension.m
//  仿爱限免
//
//  Created by 张张张小烦 on 16/5/11.
//  Copyright © 2016年 YK. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (BOOL)isThisYear {
    // 获得一个日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 取出年份
    NSDateComponents *dateCom = [calendar components:NSCalendarUnitYear
                                            fromDate:self];
    // 现在的年份
    NSDateComponents *dateNow = [calendar components:NSCalendarUnitYear
                                            fromDate:[NSDate date]];
    
    return dateCom.year == dateNow.year;
}

//- (BOOL)isTomorrow {
    
    //NSDate *nowDate = [NSDate date];
    
    //NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    //dateFomatter.dateFormat = @"yyyy-MM-dd";
    
    //// 系统时间字符串
    //NSString *sysDateStr = [dateFomatter stringFromDate:self];
    //// 当前时间字符串
    //NSString *nowDateStr = [dateFomatter stringFromDate:nowDate];
    
    //// 系统时间日期
    //NSDate *sysDate = [dateFomatter dateFromString:sysDateStr];
    //// 当前时间日期
    //nowDate = [dateFomatter dateFromString:nowDateStr];
    
    //// 当前日历
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    //| NSCalendarUnitDay;
    
    //// 对比时间差
    //NSDateComponents *dateCom = [calendar components:unit fromDate:sysDate toDate:nowDate options:0];
    
    //return dateCom.year == 0 && dateCom.month == 0 && dateCom.day == 1;
//}

- (BOOL)isToday {
    
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFor = [[NSDateFormatter alloc] init];
    dateFor.dateFormat = @"yyyy-MM-dd";
    
    // 系统时间字符串
    NSString *sysDateStr = [dateFor stringFromDate:self];
    // 当前时间字符串
    NSString *nowDateStr = [dateFor stringFromDate:nowDate];
    
    return [sysDateStr isEqualToString:nowDateStr];
}



















@end
