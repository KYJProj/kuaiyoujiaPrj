//
//  TTIntroView.h
//  kyjlandlord
//
//  CrTTted by TTc on 15-3-17.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTIntroPage.h"


@protocol TTIntroDelegate
@optional
- (void)introDidFinish;
@end

@interface TTIntroView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) id<TTIntroDelegate> delegate;

// titleView Y position - from top of the screen
// pageControl Y position - from bottom of the screen
@property (nonatomic, assign) bool swipeToExit;
@property (nonatomic, assign) bool hideOffscreenPages;
@property (nonatomic, retain) UIImage *bgImage;
@property (nonatomic, retain) UIView *titleView;
@property (nonatomic, assign) CGFloat titleViewY;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat pageControlY;
@property (nonatomic, retain) UIButton *skipButton;

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UIImageView *pageBgBack;
@property (nonatomic, retain) UIImageView *pageBgFront;
@property (nonatomic, retain) NSArray *pages;

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray;

- (void)showInView:(UIView *)view animateDuration:(CGFloat)duration;
- (void)hideWithFadeOutDuration:(CGFloat)duration;

@end