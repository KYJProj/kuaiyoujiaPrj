//
//  UILabel+(extend).m
//  KYJ
//
//  Created by TTc on 15-2-11.
//  Copyright (c) 2015年 kuaiyoujia.com. All rights reserved.
//

#import "UILabel+extend.h"

@implementation UILabel(extend)

+(UILabel *)creatLabel:(CGRect)rect{
    UILabel *label = [[UILabel alloc]init];
    label.frame = rect;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName: @"helvetica" size:16];
    label.textColor = [UIColor hexChangeFloat:@"666666"];
    label.backgroundColor= [UIColor hexChangeFloat:@"f5f5f5"];
    return  label;
}


@end