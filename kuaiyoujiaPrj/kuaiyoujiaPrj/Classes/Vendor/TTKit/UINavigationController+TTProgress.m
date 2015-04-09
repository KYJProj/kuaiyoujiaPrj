//
//  UINavigationController+TTProgress.m
//  KYJ
//
//  Created by TTc on 15-1-4.
//  Copyright (c) 2015年 kuaiyoujia.com. All rights reserved.
//

#import "UINavigationController+TTProgress.h"
NSInteger const TTProgresstagId = 0x88888;
NSInteger const TTProgressMasktagId = 0x88887;
NSInteger const TTProgressMiniMasktagId = 0x88886;
CGFloat   const TTProgressBarHeight = 2.5;

@implementation UINavigationController(TTProgress)



- (CGRect)getSGMaskFrame
{
    float navBarHeight = self.navigationBar.frame.size.height;
    float navBarY = self.navigationBar.frame.origin.y;
    
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height - navBarHeight - navBarY;
    float x = 0;
    float y = navBarHeight + navBarY;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)getSGMiniMaskFrame
{
    float width = self.navigationBar.frame.size.width;
    float height = self.navigationBar.frame.size.height + self.navigationBar.frame.origin.y - TTProgressBarHeight;
    
    return CGRectMake(0, 0, width, height);
}

- (UIColor *)getSGMaskColor
{
    return [UIColor colorWithWhite:0 alpha:0.4];
}

- (UIView *)setupTTProgressSubview
{
    return [self setupTTProgressSubviewWithTintColor:self.navigationBar.tintColor];
}

- (UIView *)setupTTProgressSubviewWithTintColor:(UIColor *)tintColor
{
    float y = self.navigationBar.frame.size.height - TTProgressBarHeight;
    
    UIView *progressView;
    for (UIView *subview in [self.navigationBar subviews])
    {
        if (subview.tag == TTProgresstagId)
        {
            progressView = subview;
        }
    }
    
    if(!progressView)
    {
        progressView = [[UIView alloc] initWithFrame:CGRectMake(0, y, 0, TTProgressBarHeight)];
        progressView.tag = TTProgresstagId;
        progressView.backgroundColor = tintColor;
        [self.navigationBar addSubview:progressView];
    }
    else
    {
        CGRect progressFrame = progressView.frame;
        progressFrame.origin.y = y;
        progressView.frame = progressFrame;
    }
    
    return progressView;
}

- (void)setupTTProgressMask
{
    UIView *mask;
    UIView *miniMask;
    for (UIView *subview in [self.view subviews])
    {
        if (subview.tag == TTProgressMasktagId)
        {
            mask = subview;
        }
        
        if (subview.tag == TTProgressMiniMasktagId)
        {
            miniMask = subview;
        }
    }
    
    if(!mask)
    {
        mask = [[UIView alloc] initWithFrame:[self getSGMaskFrame]];
        mask.tag = TTProgressMasktagId;
        mask.backgroundColor = [self getSGMaskColor];
        mask.alpha = 0;
        
        miniMask = [[UIView alloc] initWithFrame:[self getSGMiniMaskFrame]];
        miniMask.tag = TTProgressMiniMasktagId;
        miniMask.backgroundColor = [self getSGMaskColor];
        miniMask.alpha = 0;
        
        [self.view addSubview:mask];
        [self.view addSubview:miniMask];
        [UIView animateWithDuration:0.2 animations:^{
            mask.alpha = 1;
            miniMask.alpha = 1;
        }];
    }
    else
    {
        mask.frame = [self getSGMaskFrame];
        miniMask.frame = [self getSGMiniMaskFrame];
    }
}

- (void)removeSGMask
{
    for (UIView *subview in [self.view subviews])
    {
        if (subview.tag == TTProgressMasktagId || subview.tag == TTProgressMiniMasktagId)
        {
            [UIView animateWithDuration:0.3 animations:^{
                subview.alpha = 0;
            } completion:^(BOOL finished) {
                [subview removeFromSuperview];
                self.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
            }];
        }
    }
}

- (void)resetTitle
{
    BOOL titleChanged = [[[NSUserDefaults standardUserDefaults] objectForKey:kTTProgressTitleChanged] boolValue];
    
    if(titleChanged)
    {
        NSString *oldTitle = [[NSUserDefaults standardUserDefaults] objectForKey:kTTProgressOldTitle];
        //add animation
        self.visibleViewController.navigationItem.title = oldTitle;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:kTTProgressTitleChanged];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kTTProgressOldTitle];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)changeTTProgressWithTitle:(NSString *)title
{
    BOOL titleAlreadyChanged = [[[NSUserDefaults standardUserDefaults] objectForKey:kTTProgressTitleChanged] boolValue];
    if(!titleAlreadyChanged)
    {
        NSString *oldTitle = self.visibleViewController.navigationItem.title;
        [[NSUserDefaults standardUserDefaults] setObject:oldTitle forKey:kTTProgressOldTitle];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:kTTProgressTitleChanged];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //add animation
        self.visibleViewController.navigationItem.title = title;
    }
}

- (void)setTintModeAndSetupMask
{
    self.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    [self setupTTProgressMask];
}

- (void)viewUpdatesForPercentage:(float)percentage andTintColor:(UIColor *)tintColor
{
    UIView *progressView = [self setupTTProgressSubviewWithTintColor:tintColor];
    float maxWidth = self.navigationBar.frame.size.width;
    float progressWidth = maxWidth * (percentage / 100);
    
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect progressFrame = progressView.frame;
        progressFrame.size.width = progressWidth;
        progressView.frame = progressFrame;
        
    } completion:^(BOOL finished)
     {
         if(percentage >= 100.0)
         {
             [UIView animateWithDuration:0.5 animations:^{
                 progressView.alpha = 0;
             } completion:^(BOOL finished) {
                 [progressView removeFromSuperview];
                 [self removeSGMask];
                 [self resetTitle];
             }];
         }
     }];
}

#pragma mark user functions
- (void)showTTProgress
{
    [self showTTProgressWithDuration:3];
}

- (void)showTTProgressWithDuration:(float)duration
{
    [self showTTProgressWithDuration:duration andTintColor:self.navigationBar.tintColor];
}

- (void)showTTProgressWithDuration:(float)duration andTintColor:(UIColor *)tintColor andTitle:(NSString *)title
{
    [self changeTTProgressWithTitle:title];
    [self showTTProgressWithDuration:duration andTintColor:tintColor];
}

- (void)showTTProgressWithDuration:(float)duration andTintColor:(UIColor *)tintColor
{
    UIView *progressView = [self setupTTProgressSubviewWithTintColor:tintColor];
    
    float maxWidth = self.navigationBar.frame.size.width;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect progressFrame = progressView.frame;
        progressFrame.size.width = maxWidth;
        progressView.frame = progressFrame;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            progressView.alpha = 0;
        } completion:^(BOOL finished) {
            [progressView removeFromSuperview];
            [self removeSGMask];
            [self resetTitle];
        }];
    }];
}

- (void)showTTProgressWithMaskAndDuration:(float)duration andTitle:(NSString *) title
{
    [self changeTTProgressWithTitle:title];
    [self showTTProgressWithMaskAndDuration:duration];
    
}

- (void)showTTProgressWithMaskAndDuration:(float)duration
{
    UIColor *tintColor = self.navigationBar.tintColor;
    self.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    [self setupTTProgressMask];
    [self showTTProgressWithDuration:duration andTintColor:tintColor];
    
}

- (void)finishTTProgress
{
    UIView *progressView = [self setupTTProgressSubview];
    
    if(progressView)
    {
        [UIView animateWithDuration:0.1 animations:^{
            CGRect progressFrame = progressView.frame;
            progressFrame.size.width = progressFrame.size.width + 1;
            progressView.frame = progressFrame;
        }];
    }
}

- (void)cancelTTProgress {
    UIView *progressView = [self setupTTProgressSubview];
    
    if(progressView)
    {
        [UIView animateWithDuration:0.5 animations:^{
            progressView.alpha = 0;
        } completion:^(BOOL finished) {
            [progressView removeFromSuperview];
            [self removeSGMask];
            [self resetTitle];
        }];
    }
}

- (void)setTTProgressMaskWithPercentage:(float)percentage
{
    UIColor *tintColor = self.navigationBar.tintColor;
    
    if([NSThread isMainThread])
    {
        [self setTintModeAndSetupMask];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setTintModeAndSetupMask];
        });
    }
    
    [self setTTProgressPercentage:percentage andTintColor:tintColor];
}

- (void)setTTProgressMaskWithPercentage:(float)percentage andTitle:(NSString *)title
{
    [self changeTTProgressWithTitle:title];
    [self setTTProgressMaskWithPercentage:percentage];
}

- (void)setTTProgressPercentage:(float)percentage
{
    [self setTTProgressPercentage:percentage andTintColor:self.navigationBar.tintColor];
}

- (void)setTTProgressPercentage:(float)percentage andTitle:(NSString *)title
{
    [self changeTTProgressWithTitle:title];
    [self setTTProgressPercentage:percentage andTintColor:self.navigationBar.tintColor];
}

- (void)setTTProgressPercentage:(float)percentage andTintColor:(UIColor *)tintColor
{
    if (percentage > 100.0)
    {
        percentage = 100.0;
    }
    else if(percentage < 0)
    {
        percentage = 0;
    }
    
    if([NSThread isMainThread])
    {
        [self viewUpdatesForPercentage:percentage andTintColor:tintColor];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self viewUpdatesForPercentage:percentage andTintColor:tintColor];
        });
    }
}

@end
