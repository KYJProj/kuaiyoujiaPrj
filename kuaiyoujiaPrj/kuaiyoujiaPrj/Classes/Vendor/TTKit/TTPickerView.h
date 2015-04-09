//
//  TTPickerView.h
//  KYJ
//
//  Created by TTc on 15-1-4.
//  Copyright (c) 2015年 kuaiyoujia.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTPickerView : UIView
@property(nonatomic,strong)UIColor *tintColor;
@property(nonatomic,strong)NSDictionary *dataDict;
@property(nonatomic,strong)NSDictionary *items;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,assign)float rowHeight;
@property(nonatomic,assign)float rowWidth;
@property(nonatomic,strong)UIFont *font;
+(instancetype)newPickerView:(CGRect)frame titles:(NSArray*)titles items:(NSDictionary*)items;
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles items:(NSDictionary*)items;
@end
