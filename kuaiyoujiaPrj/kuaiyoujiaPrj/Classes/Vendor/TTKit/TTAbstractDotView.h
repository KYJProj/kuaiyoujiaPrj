//
//  TTAbstractDotView.h
//  kyjlandlord
//
//  Created by TTc on 15-3-18.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTAbstractDotView : UIView


/**
 *  A method call let view know which state appearance it should take. Active meaning it's current page. Inactive not the current page.
 *
 *  @param active BOOL to tell if view is active or not
 */
- (void)changeActivityState:(BOOL)active;


@end