//
//  TTSpinner.h
//  KYJ
//
//  Created by TTc on 15-1-4.
//  Copyright (c) 2015年 kuaiyoujia.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTSpinner : UIView

@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) BOOL hidesWhenStopped;
@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;
@property (nonatomic, readonly) BOOL isAnimating;

- (void)startAnimating;
- (void)stopAnimating;

@end
