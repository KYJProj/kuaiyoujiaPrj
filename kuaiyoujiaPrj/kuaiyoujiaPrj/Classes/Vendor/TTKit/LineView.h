//
//  LineView.h
//  KYJ
//
//  Created by TTc on 15-2-12.
//  Copyright (c) 2015年 kuaiyoujia.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineView : UIView
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,strong)UIColor *color;
@property(nonatomic,assign)CGPoint headP;
@property(nonatomic,assign)CGPoint tailP;
-(instancetype)initWithFrame:(CGRect)frame;

@end
