//
//  TMenuBar.m
//  UApp
//
//  Created by bill on 14-10-17.
//  Copyright (c) 2014年 _Gear. All rights reserved.
//

#import "TMenuBar.h"

@interface TMenuBar ()

@property (nonatomic, strong) NSArray       *titles;
@property (nonatomic, strong) TMenuClick    menuClick;

@end

@implementation TMenuBar

+ (id)newMenuBar:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

/// 刷新MenuBar
- (void)layoutWithTitles:(NSArray *)titles click:(TMenuClick)click;
{
    self.menuClick = click;
    self.titles = titles;
}

#pragma mark - -------- private ----------

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        _lastIndex = -1;
    }
    
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    if (!titles || ([titles count] < 1)) {
        return;
    }
    
    _titles = titles;
    
    float   sX = 0;
    float   sY = 0;
    float   subW = 10; // 间隙
    float   menuW = self.frame.size.width;
    float   btnW = titles.count < 5 ? (menuW / titles.count) - subW : 80;
    float   btnY = (self.frame.size.height - sY * 2);
    
    for (int i = 0; i < _titles.count; i++) {
        NSString *title = [[_titles objectAtIndex:i] description];
        UIButton *tButton = nil;
        tButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tButton.frame = CGRectMake(sX + (btnW + subW) * i, sY, btnW, btnY);
        tButton.tag = 100 + i;
        tButton.backgroundColor = [UIColor lightGrayColor];
        tButton.adjustsImageWhenHighlighted = NO;
        [tButton setTitle:title forState:UIControlStateNormal];
        [tButton.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
        // 设置选中样式 背景图片 文字颜色等等
        [tButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//        [tButton setBackgroundImage:[UIImage imageNamed:@"<#x#>"] forState:UIControlStateNormal];
//        [tButton setBackgroundImage:[UIImage imageNamed:@"<#x#>"] forState:UIControlStateSelected];
        [tButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tButton];
    }
    self.contentMode = UIViewContentModeTop;
    self.contentSize = CGSizeMake((btnW + 10) * _titles.count - subW,0);
}

- (void)btnClick:(UIButton *)button
{
    NSInteger tag = [button tag] - 100;
    
    //    if (tag == _lastIndex) {
    //        return;
    //    }
    
    [(UIButton *)[self viewWithTag:100 + _lastIndex] setSelected : NO];
    [(UIButton *)[self viewWithTag:100 + tag] setSelected : YES];
    _lastIndex = tag;
    
    if (self.menuClick) {
        self.menuClick(button);
    }
}

-(void)setTitle:(NSString*)title{
    UIButton * tButton = (UIButton*)[self viewWithTag:100 + _lastIndex];
    [tButton setTitle:title forState:UIControlStateNormal];
    [tButton.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
    
}

@end