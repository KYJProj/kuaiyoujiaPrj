//
//  TTProgressPopUpView.h
//  KYJ
//
//  Created by TTc on 15-1-4.
//  Copyright (c) 2015年 kuaiyoujia.com. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>
@protocol TTProgressPopUpViewDelegate;
@protocol TTProgressPopUpViewDataSource;

@interface TTProgressPopUpView : UIProgressView

- (void)showPopUpViewAnimated:(BOOL)animated;
- (void)hidePopUpViewAnimated:(BOOL)animated;

@property (strong, nonatomic) UIColor *textColor;

// font can not be nil, it must be a valid UIFont
// default is ‘boldSystemFontOfSize:20.0’
@property (strong, nonatomic) UIFont *font;

// setting the value of 'popUpViewColor' overrides 'popUpViewAnimatedColors' and vice versa
// the return value of 'popUpViewColor' is the currently displayed value
// this will vary if 'popUpViewAnimatedColors' is set (see below)
@property (strong, nonatomic) UIColor *popUpViewColor;

// pass an array of 2 or more UIColors to animate the color change as the progress updates
@property (strong, nonatomic) NSArray *popUpViewAnimatedColors;

// the above @property distributes the colors evenly across the progress view
// to specify the exact position of colors, pass an NSArray of NSNumbers (in the range 0.0 - 1.0)
- (void)setPopUpViewAnimatedColors:(NSArray *)popUpViewAnimatedColors withPositions:(NSArray *)positions;

// radius of the popUpView, default is 4.0
@property (nonatomic) CGFloat popUpViewCornerRadius;

// changes the progress track to match current popUpView color
// the track color alpha is always set to 1.0, even if popUpView color is less than 1.0
@property (nonatomic) BOOL autoAdjustTrackColor; // (default is YES)

// by default the popUpView displays progress from 0% - 100%
// to display custom text instead, implement the datasource protocol - see below
@property (weak, nonatomic) id<TTProgressPopUpViewDataSource> dataSource;

// delegate is only needed when used with a TableView or CollectionView - see below
@property (weak, nonatomic) id<TTProgressPopUpViewDelegate> delegate;
@end


// to supply custom text to the popUpView label, implement <TTProgressPopUpViewDataSource>
// the dataSource will be messaged each time the progress changes
@protocol TTProgressPopUpViewDataSource <NSObject>
- (NSString *)progressView:(TTProgressPopUpView *)progressView stringForProgress:(float)progress;

@optional
// by default the popUpView precalculates the largest size required and uses this size to display all values
// if you'd prefer the popUpView to change size as the text values change then return NO from this method
- (BOOL)progressViewShouldPreCalculatePopUpViewSize:(TTProgressPopUpView *)progressView;
@end


// when embedding an TTProgressPopUpView inside a TableView or CollectionView
// you need to ensure that the cell it resides in is brought to the front of the view hierarchy
// to prevent the popUpView from being obscured
@protocol TTProgressPopUpViewDelegate <NSObject>
- (void)progressViewWillDisplayPopUpView:(TTProgressPopUpView *)progressView;

@optional
- (void)progressViewDidHidePopUpView:(TTProgressPopUpView *)progressView;
@end