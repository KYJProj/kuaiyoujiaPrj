//
//  MapUtils.h
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BMapKit.h"
@class BMKMapView;
typedef void (^GetLocaltionInfo)(CLLocationCoordinate2D locationPt,NSString *addressStr,BMKSearchErrorCode code);

#define MCoordinateMake(lat, long)  CLLocationCoordinate2DMake((lat), (long))
#define MCoordinateZero             CLLocationCoordinate2DMake(0, 0)
#define GZ_Center_Loc               CLLocationCoordinate2DMake(23.128205,113.266785)
#define FY_Center_Loc               CLLocationCoordinate2DMake(23.0408763885498,113.1931457519531)
#define GZ_Location                 [MLocation locationCoord:GZ_Center_Loc tIdentifier:@"icon_center_point.png"]


//23.036388,113.19356   google
//23.040876,113.19314   百度
@interface MapUtils : NSObject<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKGeneralDelegate,BMKMapViewDelegate>
{
    BMKMapView* _mapView;
    BMKLocationService* _locService;
    BMKGeoCodeSearch* _geocodesearch;
    bool isGeoSearch;
}

@property (nonatomic, copy) GetLocaltionInfo getLocaltionInfoBlock;


+(instancetype)shareInstance;
-(void)startLocationService;
-(void)stopLocationService;
-(void)startGeoCodeSearchService;
-(void)onClickReverseGeocode:(CLLocationCoordinate2D)pt;
-(void)locationInit;
-(void)destroyLocation;



/// 启动地图服务
-(BOOL) startBMap;
/// 停止地图服务
-(BOOL) stopBMap;

/// 重启地图服务
-(BOOL) reStartBMap;
/// 获取地图错误码对应描述
-(NSString*) mmapErrorCode:(int)code;
@end
