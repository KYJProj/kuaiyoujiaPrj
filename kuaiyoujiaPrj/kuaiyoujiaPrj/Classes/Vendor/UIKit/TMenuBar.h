//
//  TMenuBar.h
//  UApp
//
//  Created by bill on 14-10-17.
//  Copyright (c) 2014年 _Gear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TMenuClick)(UIButton *sender);

@interface TMenuBar : UIScrollView
{
    //UIScrollView* _scrollView;
    NSInteger _lastIndex;
}

/// 初始化MenuBar
+(id) newMenuBar:(CGRect)frame;

/// 刷新MenuBar
-(void) layoutWithTitles:(NSArray*)titles click:(TMenuClick)click;

-(void)setTitle:(NSString*)title;
@end
