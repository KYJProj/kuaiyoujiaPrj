//
//  NSObject+Help.h
//  Rent_OC
//
//  Created by TTc on 14-10-24.
//  Copyright (c) 2014年 com.kuaiyoujia.rent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject(Model)
+(NSDictionary *) getDicFromNormalClass:(id) classInstance;
@end

@interface NSObject(Help)
+(NSString*)setState:(int)state;
+(NSString*)setShelves:(int)shelves;
+(NSString*)setAuthStatus:(int)authStatus;
+(NSString*)setBidHouseStatus:(int)bidHouseStatus;
+(NSString*)setHasPayMoney:(int)hasPayMoney;
+(NSString*)setPreRentTag:(int)preRentTag;
+(NSString*)setIsonePrice:(int)isOnePrice;
+(NSInteger)setRentTypeParm:(NSString*)rentType;
+(NSString*)setRentType:(int)rentType;
+(NSInteger)setBuildingTypeParm:(NSString*)buildingType;
+(NSString*)setBuildingType:(int)buildingType;
+(NSInteger)setTypeParm:(NSString*)Type;
+(NSString*)setType:(int)Type;
+(NSString*)setSupportingFacilities:(int)Type;
+(NSInteger)setStructureParm:(NSString*)structure;
+(NSString*)setStructure:(int)structure;
+(NSInteger)setPayTypeParm:(NSString*)mPayType;
+(NSString*)setPayType:(int)payType;
+(NSInteger)setActivityTypeParm:(NSString*)activityType;
+(NSString*)setActivityType:(int)activityType;
+(NSInteger)setOfficeTypeParm:(NSString*)officeType;
+(NSString*)setOfficeType:(int)officeType;
+(NSInteger)setPropertyTypeParm:(NSString*)propertyType;
+(NSString*)setPropertyType:(int)propertyType;
+(NSString*)setHouseTypeValue:(int)houseType propertyType:(int)propertyType;
+(NSString *)setDirectionType:(int)directionType;
+(NSString*)setPhoneType:(int)phoneType;
+(NSString *)setRenovationType:(int)renovationType;
+(NSString *)setBuildingYear:(int)buildingYear;
+(NSString *)setFeatures:(int)features;
+(NSString *)setSex:(int)sex;
@end



@interface NSObject(Block)
//perform block1 in main thread,when finished perform block2 in background
+(void)perform:(void(^)())block1 withCompletionHandler:(void (^)())block2;
-(void)perform:(void(^)())block1 withCompletionHandler:(void (^)())block2;


-(void)setZXObject:(id)obj;
-(id)getZXObject;



//默认block回调 key:zxDefaultEventHandler
-(void)handlerDefaultEventWithBlock:(id)block;
-(id)blockForDefaultEvent;

//设置一个block作为回调
-(void)handlerEventWithBlock:(id)block withIdentifier:(NSString *)identifier;
-(id)blockForEventWithIdentifier:(NSString *)identifier;

//send object
//handle block with default identifier is @"ZXObjectSingleObjectDictionary".
-(void)receiveObject:(void(^)(id object))sendObject;
-(void)sendObject:(id)object;

//tag can't be nil
-(void)receiveObject:(void(^)(id object))sendObject withIdentifier:(NSString *)identifier;
-(void)sendObject:(id)object withIdentifier:(NSString *)identifier;
//给UITableViewCell的数据存储计算过的行高的，防止重复计算
//类似于setZXObject,不过这个意义更明确
-(float)zxRowHeight;
-(void)setZXRowHeight:(float)height;

@end