//
//  UITableViewCell+extend.m
//  KYJ
//
//  Created by TTc on 15-2-11.
//  Copyright (c) 2015年 kuaiyoujia.com. All rights reserved.
//

#import "UITableViewCell+extend.h"

@implementation UITableViewCell(extend)


- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 0.5);
    CGContextSetStrokeColorWithColor(ctx, [UIColor hexChangeFloat:@"cccccc"].CGColor);
    
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, self.frame.size.width, 0);

    
    CGContextMoveToPoint(ctx, 0, self.frame.size.height);
    CGContextAddLineToPoint(ctx, self.frame.size.width, self.frame.size.height);
    CGContextStrokePath(ctx);
//    CGContextSetFillColorWithColor(ctx, [UIColor hexChangeFloat:@"cccccc"].CGColor);
//    CGContextFillRect(ctx, rect);
//    
//    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0xE2/255.0f green:0xE2/255.0f blue:0xE2/255.0f alpha:1].CGColor);
//    CGContextStrokeRect(ctx, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
}

@end
