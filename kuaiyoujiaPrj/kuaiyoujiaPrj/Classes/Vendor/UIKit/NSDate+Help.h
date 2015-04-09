//
//  NSDate+Help.h
//  iKanReader
//
//  Created by liutian liutian on 12-4-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(Help)

- (NSUInteger)getDay;

- (NSUInteger)getMonth;

- (NSUInteger)getYear;

- (int )getHour;

- (int)getMinute;

+(NSString *)strToDate:(NSDate*)date;

+(NSDate*)dateToStr:(NSString*)string ;

+(NSDate *)strToShortDate:(NSString *)string;

+(NSString*)dateToShortStr:(NSDate*)date;

//json 毫秒返回 格式化的时间点
+(NSString *)timeIntervalToString:(NSString *)timeInterval;

+(NSString *)stringToDate:(NSDate*)date;

+(NSString *)getCurrentTime;
@end
