//
//  DKDropdownAlert.h
//  DropdownAlert
//
//  Created by TTc on 14-10-9.
//  Copyright (c) 2014年 kuaiyoujia.com. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface RKDropdownAlert : UIButton


//%%% Additions: title, message, time, background color, text color

+(void)show;
+(void)title:(NSString*)title;
+(void)title:(NSString*)title time:(NSInteger)seconds;
+(void)title:(NSString*)title backgroundColor:(UIColor*)backgroundColor textColor:(UIColor*)textColor;
+(void)title:(NSString*)title backgroundColor:(UIColor*)backgroundColor textColor:(UIColor*)textColor time:(NSInteger)seconds;

+(void)title:(NSString*)title message:(NSString*)message;
+(void)title:(NSString*)title message:(NSString*)message time:(NSInteger)seconds;
+(void)title:(NSString*)title message:(NSString*)message backgroundColor:(UIColor*)backgroundColor textColor:(UIColor*)textColor;
+(void)title:(NSString*)title message:(NSString*)message backgroundColor:(UIColor*)backgroundColor textColor:(UIColor*)textColor time:(NSInteger)seconds;


@property(nonatomic,strong) UIColor *defaultViewColor;
@property(nonatomic,strong) UIColor *defaultTextColor;

-(void)title:(NSString*)title message:(NSString*)message backgroundColor:(UIColor*)backgroundColor textColor:(UIColor*)textColor time:(NSInteger)seconds;

@end
