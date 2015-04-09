//
//  TTIntroPage.h
//  kyjlandlord
//
//  Created by TTc on 15-3-17.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTIntroPage : NSObject

// title image Y position - from top of the screen
// title and description labels Y position - from bottom of the screen
@property (nonatomic, retain) UIImage *bgImage;
@property (nonatomic, retain) UIImage *titleImage;
@property (nonatomic, assign) CGFloat imgPositionY;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, assign) CGFloat titlePositionY;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) UIFont *descFont;
@property (nonatomic, retain) UIColor *descColor;
@property (nonatomic, assign) CGFloat descPositionY;

// if customView is set - all other properties are ignored
@property (nonatomic, retain) UIView *customView;

+ (TTIntroPage *)page;
+ (TTIntroPage *)pageWithCustomView:(UIView *)customV;

@end