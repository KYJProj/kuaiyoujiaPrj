//
//  TTIntroPage.m
//  kyjlandlord
//
//  Created by TTc on 15-3-17.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "TTIntroPage.h"

@implementation TTIntroPage


+ (TTIntroPage *)page {
    TTIntroPage *newPage = [[TTIntroPage alloc] init];
    newPage.imgPositionY    = 50.0f;
    newPage.titlePositionY  = 160.0f;
    newPage.descPositionY   = 140.0f;
    newPage.title = @"";
    newPage.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
    newPage.titleColor = [UIColor whiteColor];
    newPage.desc = @"";
    newPage.descFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0];
    newPage.descColor = [UIColor whiteColor];
    
    return newPage;
}

+ (TTIntroPage *)pageWithCustomView:(UIView *)customV {
    TTIntroPage *newPage = [[TTIntroPage alloc] init];
    newPage.customView = customV;
    
    return newPage;
}

@end

