//
//  TTAbstractDotView.m
//  kyjlandlord
//
//  Created by TTc on 15-3-18.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "TTAbstractDotView.h"

@implementation TTAbstractDotView


- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class]
                                 userInfo:nil];
}


- (void)changeActivityState:(BOOL)active
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class]
                                 userInfo:nil];
}

@end
