//
//  LineView.m
//  KYJ
//
//  Created by TTc on 15-2-12.
//  Copyright (c) 2015年 kuaiyoujia.com. All rights reserved.
//

#import "LineView.h"

@implementation LineView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil){
        _headP = CGPointMake(frame.origin.x,  frame.size.height/2);
        _tailP = CGPointMake(frame.size.width,frame.size.height/2);
        _width = 0.5f;
        _color = [UIColor hexChangeFloat:@"cccccc"];
        

    }
    return self;
}



-(void)drawRect:(CGRect)rect {
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, _width);
    CGContextSetStrokeColorWithColor(ctx, _color.CGColor);
    CGContextMoveToPoint(ctx,_headP.x,_headP.y);
    CGContextAddLineToPoint(ctx,_tailP.x,_tailP.y);
    CGContextStrokePath(ctx);
}


@end
