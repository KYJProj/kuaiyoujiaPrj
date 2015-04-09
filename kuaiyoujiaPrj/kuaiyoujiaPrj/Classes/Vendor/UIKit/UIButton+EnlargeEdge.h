//
//  UIButton+EnlargeEdge.h
//  Rent_OC
//
//  Created by TTc on 14-11-24.
//  Copyright (c) 2014年 com.kuaiyoujia.rent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface UIButton(EnlargeEdge)
- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end


@interface UIButton(extend)

+(UIButton *)creatButton:(CGRect)rect  img:(UIImage*)img  title:(NSString *)title imgEdgeInsets:(UIEdgeInsets)imgEdgeInsets titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets sel:(SEL)sel  target:(id)target;
@end
