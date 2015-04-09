//
//  BaseModel.m
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (id)initContentWithDic:(NSDictionary *)jsonDic
{
    self = [super init];
    if (self != nil) {
        [self setAttributes:jsonDic];
    }
    
    return self;
}

- (void)setAttributes:(NSDictionary *)jsonDic
{
    
    /*
     key:  json字典的key名
     value: model对象的属性名
     */
    //mapDic： 属性名与json字典的key 的映射关系
    NSDictionary *mapDic = [self attributeMapDictionary:jsonDic];
    
    for (NSString *jsonKey in mapDic) {
        
        //modelAttr:"newsId"
        //jsonKey : "id"
        NSString *modelAttr = [mapDic objectForKey:jsonKey];
        SEL seletor = [self stringToSel:modelAttr];
        
        //判断self 是否有seletor 方法
        if ([self respondsToSelector:seletor]) {
            //json字典中的value
            id value = [jsonDic objectForKey:jsonKey];
            
            if ([value isKindOfClass:[NSNull class]]) {
                value = @"";
            }
            //强制把NSNumber 转NSString
            if([value isKindOfClass:[NSNumber class]]){
                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                value = [numberFormatter stringFromNumber:value];
            }
            
            //调用属性的设置器方法，参数是json的value
            [self performSelector:seletor withObject:value];
            
        }
        
    }
}

/*
 SEL 类型的创建方式有两种，例如：setNewsId: 的SEL类型
 1.第一种
 SEL selector = @selector(setNewsId:)
 2.第二种
 SEL selector = NSSelectorFromString(@"setNewsId:");
 */

//将属性名转成SEL类型的set方法
//newsId  --> setNewsId:
- (SEL)stringToSel:(NSString *)attName
{
    NSString *first = [[attName substringToIndex:1] uppercaseString];
    NSString *end = [attName substringFromIndex:1];
    NSString *setMethod = [NSString stringWithFormat:@"set%@%@:",first,end];
    //将字符串转成SEL类型
    return NSSelectorFromString(setMethod);
}

/*
 属性名与json字典中key的映射关系
 key:  json字典的key名
 value: model对象的属性名
 */
- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic
{
    
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionary];
    for (id key in jsonDic) {
        [mapDic setObject:key forKey:key];
    }
    return mapDic;
}

- (NSString *)description{
    NSMutableString *attrsDesc = [NSMutableString stringWithCapacity:100];
    NSDictionary *attrMapDic = [self attributeMapDictionary];
    NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
    id attributeName;
    
    while ((attributeName = [keyEnum nextObject])) {
        SEL getSel = NSSelectorFromString(attributeName);
        if ([self respondsToSelector:getSel]) {
            NSMethodSignature *signature = nil;
            signature = [self methodSignatureForSelector:getSel];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:self];
            [invocation setSelector:getSel];
            NSObject *valueObj = nil;
            [invocation invoke];
            [invocation getReturnValue:&valueObj];
            //            ITTDINFO(@"attributeName %@ value %@", attributeName, valueObj);
            if (valueObj) {
                [attrsDesc appendFormat:@" [%@=%@] ",attributeName, valueObj];
                //[valueObj release];
            }else {
                [attrsDesc appendFormat:@" [%@=nil] ",attributeName];
            }
            
        }
    }
    
    NSString *customDesc = [self customDescription];
    NSString *desc;
    
    if (customDesc && [customDesc length] > 0 ) {
        desc = [NSString stringWithFormat:@"%@:{%@,%@}",[self class],attrsDesc,customDesc];
    }else {
        desc = [NSString stringWithFormat:@"%@:{%@}",[self class],attrsDesc];
    }
    
    return desc;
}

- (NSString *)customDescription{
    return nil;
}
- (id)initWithCoder:(NSCoder *)decoder{
    if( self = [super init] ){
        NSDictionary *attrMapDic = [self attributeMapDictionary];
        if (attrMapDic == nil) {
            return self;
        }
        NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
        id attributeName;
        while ((attributeName = [keyEnum nextObject])) {
            SEL sel = [self getSetterSelWithAttibuteName:attributeName];
            if ([self respondsToSelector:sel]) {
                id obj = [decoder decodeObjectForKey:attributeName];
                [self performSelectorOnMainThread:sel
                                       withObject:obj
                                    waitUntilDone:[NSThread isMainThread]];
            }
        }
    }
    return self;
}

-(NSDictionary*)attributeMapDictionary{
    return nil;
}
- (void)encodeWithCoder:(NSCoder *)encoder{
    NSDictionary *attrMapDic = [self attributeMapDictionary];
    if (attrMapDic == nil) {
        return;
    }
    NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
    id attributeName;
    while ((attributeName = [keyEnum nextObject])) {
        SEL getSel = NSSelectorFromString(attributeName);
        if ([self respondsToSelector:getSel]) {
            NSMethodSignature *signature = nil;
            signature = [self methodSignatureForSelector:getSel];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:self];
            [invocation setSelector:getSel];
            NSObject *valueObj = nil;
            [invocation invoke];
            [invocation getReturnValue:&valueObj];
            
            if (valueObj) {
                [encoder encodeObject:valueObj forKey:attributeName];
            }
        }
    }
}
- (NSData*)getArchivedData{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}
-(SEL)getSetterSelWithAttibuteName:(NSString*)attributeName{
    NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
    NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
    return NSSelectorFromString(setterSelStr);
}

@end