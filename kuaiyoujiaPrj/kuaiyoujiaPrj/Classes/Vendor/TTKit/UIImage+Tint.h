//
//  UIImage+Tint.h
//  KYJ
//
//  Created by TTc on 15-1-4.
//  Copyright (c) 2015年 kuaiyoujia.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(Tint)
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

@end
