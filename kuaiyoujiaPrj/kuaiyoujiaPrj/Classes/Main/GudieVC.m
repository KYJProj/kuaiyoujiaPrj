//
//  GudieVC.m
//  kyjlandlord
//
//  Created by TTc on 15-3-17.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "GudieVC.h"
#import "TTIntroView.h"
#import "AppDelegate.h"
@interface GudieVC()

@end

@implementation GudieVC


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [self showIntroWithCrossDissolve];
}

- (void)showIntroWithCrossDissolve {
    int i;
    NSMutableArray *array = [NSMutableArray array];
    for(i=1;i<=4;i++){
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.view.frame];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d",i]];
        TTIntroPage *page = [TTIntroPage pageWithCustomView:imgView];
        
        [array addObject:page];
    }
    TTIntroView *intro = [[TTIntroView alloc] initWithFrame:self.view.bounds andPages:array];
    [intro setDelegate:[AppDelegate shareInstance]];
    [intro showInView:self.view animateDuration:0.0];
}



@end
