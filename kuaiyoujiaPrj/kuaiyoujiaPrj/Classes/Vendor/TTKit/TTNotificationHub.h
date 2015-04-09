//
//  TTNotificationHub.h
//  KYJ
//
//  Created by TTc on 15-1-4.
//  Copyright (c) 2015年 kuaiyoujia.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTNotificationHub : NSObject

//%%% setup
-(id)initWithView:(UIView *)view;

//%%% adjustment methods
-(void)setView:(UIView *)view andCount:(int)startCount;
-(void)setCircleAtFrame:(CGRect)frame;
-(void)setCircleColor:(UIColor*)circleColor labelColor:(UIColor*)labelColor;
-(void)moveCircleByX:(CGFloat)x Y:(CGFloat)y;
-(void)scaleCircleSizeBy:(CGFloat)scale;

//%%% changing the count
-(void)increment;
-(void)incrementBy:(int)amount;
-(void)decrement;
-(void)decrementBy:(int)amount;
-(void)setCount:(int)newCount;
-(int)count; // returns the count (treat as get method)

//%%% hiding / showing the count
-(void)hideCount;
-(void)showCount;

//%%% animations
-(void)pop;
-(void)blink;
-(void)bump;

@property (nonatomic)UIView *hubView;

@end
