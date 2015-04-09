//
//  MapUtils.m
//  kyjlandlord
//
//  Created by TTc on 15-3-16.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.

#import "MapUtils.h"
BMKMapManager* _mapManager;

@interface MapUtils()
@property (nonatomic, assign) BOOL _isStarting;

@end

@implementation MapUtils

+(instancetype)shareInstance{
    static MapUtils *_sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[MapUtils alloc] init];
    });
    return _sharedManager;
}
-(BOOL)isValid:(CLLocationCoordinate2D)coordinate
{
    if (coordinate.latitude == 0 && coordinate.longitude == 0) {
        return NO;
    }
    return YES;
}


-(BOOL)stopBMap
{
    BOOL isSuccess = [_mapManager stop];
    NSLog(@" ---- 地图引擎停止【%d】",isSuccess);
    return isSuccess;
}

-(BOOL)reStartBMap{
    [self stopBMap];
    return [self startBMap];
}

-(BOOL)startBMap;
{
    _mapManager = [[BMKMapManager alloc]init];
    BOOL isSuccess = [_mapManager start:BAIDU_BLS_AK generalDelegate:self];
    if (!isSuccess) {
        NSLog(@"manager start failed!");
    }
    else{
        NSLog(@" ---- 地图引擎启动【%d】",isSuccess);
    }
    return isSuccess;
}
-(void)locationInit
{
    _locService.delegate = self;
    _geocodesearch.delegate = self;
}

-(void)destroyLocation
{
    _locService.delegate = nil;
    _geocodesearch.delegate = nil; // 不用时，置nil
}

//启动定位与地理位置编码
-(void)startGeoCodeSearchService
{
    if (_geocodesearch==nil) {
        _geocodesearch = [[BMKGeoCodeSearch alloc]init];
        _geocodesearch.delegate = self;
    }
    [_locService startUserLocationService];
}

-(void)startLocationService{
    if (_locService==nil) {
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
    }
}

-(void)stopLocationService
{
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
}


-(void)onClickReverseGeocode:(CLLocationCoordinate2D)pt
{
    isGeoSearch = false;
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}

-(void)onClickGeocode
{
    isGeoSearch = true;
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
    
}

#pragma mark BMKGeoCodeSearchDelegate
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        NSString* titleStr;
        NSString* showmeg;
        
        titleStr = @"正向地理编码";
        showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",item.coordinate.latitude,item.coordinate.longitude];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
        
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (self.getLocaltionInfoBlock)
    {
        NSLog(@"经度：%f  纬度： %f ,城市＝%@",result.location.latitude,result.location.longitude,result.address);
        self.getLocaltionInfoBlock(result.location,result.addressDetail.city,error);
    }
}




/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    
    if(![self isValid:userLocation.location.coordinate]){
        return;
    }
    else{
        [_locService stopUserLocationService];
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
        pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
        [self onClickReverseGeocode:pt];
    }
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error=%@",error);
}



#pragma mark -BMKGeneralDelegate
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
-(NSString*) mmapErrorCode:(int)code
{/********
  BMK_SEARCH_AMBIGUOUS_KEYWORD,///<检索词有岐义
  BMK_SEARCH_AMBIGUOUS_ROURE_ADDR,///<检索地址有岐义
  BMK_SEARCH_NOT_SUPPORT_BUS,///<该城市不支持公交搜索
  BMK_SEARCH_NOT_SUPPORT_BUS_2CITY,///<不支持跨城市公交
  BMK_SEARCH_RESULT_NOT_FOUND,///<没有找到检索结果
  BMK_SEARCH_ST_EN_TOO_NEAR,///<起终点太近
  ********/
    switch (code) {
        case BMKErrorConnect:
            return @"网络连接错误";
            break;
        case BMKErrorData:
            return @"数据错误";
            break;
        case BMKErrorRouteAddr:
            return @"起点或终点选择(有歧义)";
            break;
        case BMKErrorResultNotFound:
            return @"搜索结果未找到";
            break;
        case BMKErrorLocationFailed:
            return @"定位失败";
            break;
        case BMKErrorPermissionCheckFailure:
            return @"百度地图API授权Key验证失败";
            break;
        case BMKErrorParse:
            return @"数据解析失败";
            break;
        default:
            break;
    }
    return @"位置错误";
}
@end

