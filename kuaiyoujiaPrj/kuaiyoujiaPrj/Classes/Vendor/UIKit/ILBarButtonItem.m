//
//  ILBarButtonItem.m
//  zufang
//
//  Created by TTc on 14-9-23.
//  Copyright (c) 2014年 kuaiyoujia.com. All rights reserved.
//

#import "ILBarButtonItem.h"

@interface ILBarButtonItem() {
    id customTarget;
    UIButton *customButton;
}

@end

@implementation ILBarButtonItem

- (id)initWithImage:(UIImage *)image
      selectedImage:(UIImage *)selectedImage
             target:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateHighlighted];
    
    /* Init method inherited from UIBarButtonItem */
    self = [[ILBarButtonItem alloc] initWithCustomView:btn];
    
    if (self) {
        /* Assign ivars */
        customButton = btn;
        customImage = image;
        customSelectedImage = selectedImage;
        customTarget = target;
        customAction = action;
    }
    
    return self;
}


- (id)initWithTitle:(NSString *)title
             target:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    /* Init method inherited from UIBarButtonItem */
    self = [[ILBarButtonItem alloc] initWithCustomView:btn];
    
    if (self) {
        /* Assign ivars */
        customButton = btn;
        customTarget = target;
        customAction = action;
    }
    return self;
}

+(ILBarButtonItem*)barItemWithTitle:(NSString*)title target:(id)target action:(SEL)action
{
    return [[ILBarButtonItem alloc] initWithTitle:title target:target action:action];
}

+ (ILBarButtonItem *)barItemWithImage:(UIImage*)image
                        selectedImage:(UIImage*)selectedImage
                               target:(id)target
                               action:(SEL)action
{
    return [[ILBarButtonItem alloc] initWithImage:image
                                    selectedImage:selectedImage
                                           target:target
                                           action:action];
}
-(void)setTitle:(NSString *)title{
    [customButton setTitle:title forState:UIControlStateNormal];
}
-(void)setTag:(NSInteger)tag{
    customButton.tag = tag;
}
- (void)setCustomImage:(UIImage *)image {
    customImage = image;
    [customButton setImage:image forState:UIControlStateNormal];
}

- (void)setCustomSelectedImage:(UIImage *)image {
    customSelectedImage = image;
    [customButton setImage:image forState:UIControlStateHighlighted];
}

- (void)setCustomAction:(SEL)action {
    customAction = action;
    
    [customButton removeTarget:nil
                        action:NULL
              forControlEvents:UIControlEventAllEvents];
    
    [customButton addTarget:customTarget
                     action:action
           forControlEvents:UIControlEventTouchUpInside];
}

@end
