//
//  MainData.m
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "MainData.h"

@implementation MainData

+ (instancetype)shareInstance
{
    static MainData *_sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[MainData alloc] init];
    });
    return _sharedManager;
}
-(void)initCityData:(NSDictionary*)cityData{
    CityData *city = [[CityData alloc]init];
    city.cityId = [cityData objectForKey:@"id"];
    city.cityName = [cityData objectForKey:@"name"];
    city.cityPy= [cityData objectForKey:@"py"];
    city.position = [cityData objectForKey:@"position"];
    self.mCityData = city;
}

-(void)unArchive{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults objectForKey:CITY]){
        NSDictionary *dict = [userDefaults objectForKey:CITY];
        [self initCityData:dict];
    }
    else{
        NSDictionary *dict = @{@"id":@"253",@"name":@"北京",@"py":@"beijing",@"position":@"39.92998577808,116.39564503788"};
        [self initCityData:dict];
        [self archive];
    }
    [userDefaults synchronize];
}

-(void)archive{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefaults objectForKey:CITY];
    if(![[dict objectForKey:@"name"] isEqualToString:self.mCityData.cityName] && !IsNilOrNull(self.mCityData)){
        NSDictionary *dict = @{@"id":self.mCityData.cityId,@"name":self.mCityData.cityName,@"py":self.mCityData.cityPy,@"position":self.mCityData.position};
        [userDefaults setObject:dict forKey:CITY];
    }
    [userDefaults synchronize];
}


@end


@implementation CityData

@end