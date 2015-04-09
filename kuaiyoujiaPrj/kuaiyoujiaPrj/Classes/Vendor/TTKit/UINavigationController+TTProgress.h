//
//  UINavigationController+TTProgress.h
//  KYJ
//
//  Created by TTc on 15-1-4.
//  Copyright (c) 2015年 kuaiyoujia.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTTProgressTitleChanged @"kTTProgressTitleChanged"
#define kTTProgressOldTitle @"kTTProgressOldTitle"

@interface UINavigationController(TTProgress)
- (void)showTTProgress;
- (void)showTTProgressWithDuration:(float)duration;
- (void)showTTProgressWithDuration:(float)duration andTintColor:(UIColor *)tintColor;
- (void)showTTProgressWithDuration:(float)duration andTintColor:(UIColor *)tintColor andTitle:(NSString *)title;
- (void)showTTProgressWithMaskAndDuration:(float)duration;
- (void)showTTProgressWithMaskAndDuration:(float)duration andTitle:(NSString *) title;


- (void)setTTProgressPercentage:(float)percentage;
- (void)setTTProgressPercentage:(float)percentage andTitle:(NSString *)title;
- (void)setTTProgressPercentage:(float)percentage andTintColor:(UIColor *)tintColor;
- (void)setTTProgressMaskWithPercentage:(float)percentage;
- (void)setTTProgressMaskWithPercentage:(float)percentage andTitle:(NSString *)title;


- (void)finishTTProgress;
- (void)cancelTTProgress;
@end


