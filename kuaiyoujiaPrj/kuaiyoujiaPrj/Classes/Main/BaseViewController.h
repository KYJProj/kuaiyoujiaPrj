//
//  BaseViewController.h
//  kyjlandlord
//
//  Created by TTc on 15-3-9.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//
/**
 *  liutian
 */
#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
-(void)checkNetWork:(UIButton*)sender;
-(void)openInteractionEnable:(UIButton*)sender;
-(UIEdgeInsets)tableViewInsetsWithBottomValue:(CGFloat)bottom;

@end
