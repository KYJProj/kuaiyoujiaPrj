//
//  UIColor+extend.h
//  Rent
//
//  Created by TTc on 14-10-9.
//  Copyright (c) 2014年 kuaiyoujia.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(extend)
// 将十六进制颜色的字符串转化为复合iphone/ipad的颜色
// 字符串为"FFFFFF"
+ (UIColor *)hexChangeFloat:(NSString *) hexColor;

@end
