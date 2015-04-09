//
//  BaseViewController.m
//  kyjlandlord
//
//  Created by TTc on 15-3-9.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "AppSetMgr.h"
#import "Utils.h"
#import "MainData.h"
@implementation BaseViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    ILBarButtonItem *backBtn =
    [ILBarButtonItem barItemWithImage:[UIImage imageNamed:@"IPHONE_navback_btn"]
                        selectedImage:[UIImage imageNamed:@"IPHONE_navback_btn"]
                               target:self
                               action:@selector(backAction)];
    self.navigationItem.leftBarButtonItems = [[NSArray alloc]initWithObjects:backBtn, nil];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"class name ==%@,viewDidLoad  is  called!",NSStringFromClass([self class]));
}


-(UIEdgeInsets)tableViewInsetsWithBottomValue:(CGFloat)bottom {
    UIEdgeInsets insets = UIEdgeInsetsZero;
    
    if ([self respondsToSelector:@selector(topLayoutGuide)]) {
        insets.top = 64;
    }
    insets.bottom = bottom;
    return insets;
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)checkNetWork:(UIButton*)sender{
    if(![[Utils shareInstance] checkNetWorkStatus]){
        [self performSelector:@selector(openInteractionEnable:) withObject:sender afterDelay:0.4];
        return;
    }
}

-(void)openInteractionEnable:(UIButton*)sender
{
    sender.userInteractionEnabled = YES;
}

@end
