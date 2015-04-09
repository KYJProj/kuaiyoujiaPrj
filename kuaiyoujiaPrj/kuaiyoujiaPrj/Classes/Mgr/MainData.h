//
//  MainData.h
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@class CityData;
@interface MainData : NSObject

@property(nonatomic,strong)CityData *mCityData;
+ (instancetype)shareInstance;

-(void)initCityData:(NSDictionary*)cityData;

-(void)archive;
-(void)unArchive;


@end


@interface CityData : BaseModel
@property(strong,nonatomic)NSString *cityId;
@property(strong,nonatomic)NSString *cityName;
@property(strong,nonatomic)NSString *cityPy;
@property(strong,nonatomic)NSString *position;
@end
