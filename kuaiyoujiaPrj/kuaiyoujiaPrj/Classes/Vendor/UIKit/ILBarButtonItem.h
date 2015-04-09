//
//  ILBarButtonItem.h
//  zufang
//
//  Created by TTc on 14-9-23.
//  Copyright (c) 2014年 kuaiyoujia.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ILBarButtonItem : UIBarButtonItem {
    UIImage *customImage;
    UIImage *customSelectedImage;
    SEL customAction;
}

/**
 * Create and return a new bar button item.
 * @param image The image of the button to show when unselected. Works best with images under 44x44.
 * @param selectedImage The image of the button to show when the button is tapped. Works best with images under 44x44.
 * @param target The target of the selector
 * @param action The selector to perform when the button is tapped
 *
 * @return An instance of the new button to be used like a normal UIBarButtonItem
 */
+ (ILBarButtonItem *)barItemWithImage:(UIImage*)image
                        selectedImage:(UIImage*)selectedImage
                               target:(id)target
                               action:(SEL)action;
+(ILBarButtonItem*)barItemWithTitle:(NSString*)title target:(id)target action:(SEL)action;

//add setTitle
-(void)setTag:(NSInteger)tag;
-(void)setTitle:(NSString *)title;
- (void)setCustomImage:(UIImage *)image;
- (void)setCustomSelectedImage:(UIImage *)image;

- (void)setCustomAction:(SEL)action;

@end
