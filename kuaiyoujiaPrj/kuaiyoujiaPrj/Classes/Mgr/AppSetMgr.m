//
//  AppSetMgr.m
//  kyjlandlord
//
//  Created by TTc on 15-3-9.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//
/**
 *  liutian
 *
 *  @param instancetype
 *
 *  @return
 */
#import "AppSetMgr.h"
#import "Utils.h"
@implementation AppSetMgr
static NSString   *defaultsName = @"Default";

+(instancetype)shareInstance{
    static AppSetMgr *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[AppSetMgr alloc] init];
    });
    return _sharedManager;
}
/**
 *  配置帮助单
 */
-(void)setupGuideView{
    
}


/**
 *  配置日志系统
 */
-(void)setupLogInfo{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];// 启用颜色区分
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
}
/**
 *  配置网络参数
 */
-(void)setupNetwork{
    NSURL *baseURL = [NSURL URLWithString:@"http://www.kuaiyoujia.com/"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN://3g
            case AFNetworkReachabilityStatusReachableViaWiFi://wifi
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];

}



/**
 *  持久华函数
 */
-(void)ArchiveAppPro{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray  *saveArray = [[NSMutableArray alloc]init];
    [saveArray addObject:[NSNumber numberWithBool:_isOpenPush]];        //0
    [saveArray addObject:[NSNumber numberWithBool:_isShowPic]];         //1
    [saveArray addObject:[NSNumber numberWithBool:_isBellAlert_ON]];    //2
    [saveArray addObject:[NSNumber numberWithBool:_isVibration_ON]];    //3
    [saveArray addObject:[NSNumber numberWithBool:_push_Mode]];         //4
    [saveArray addObject:[NSNumber numberWithBool:_isFirstLaunch]];      //5
    [saveArray addObject:_version];      //6


    [userDefaults setObject:saveArray  forKey:defaultsName];
    [userDefaults synchronize];
    
}
/**
 *  获得持久化数据
 */
-(void)UnArchiveAppPro{
    NSUserDefaults   *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray          *getData   = [userDefaults objectForKey:defaultsName];
    if(getData != nil){
        _isOpenPush = [[getData objectAtIndex:0] boolValue]; //0
        _isShowPic  = [[getData objectAtIndex:1] boolValue];
        _isBellAlert_ON = [[getData objectAtIndex:2]boolValue];
        _isVibration_ON = [[getData objectAtIndex:3]boolValue];
        _push_Mode = [[getData objectAtIndex:4]boolValue];
        _isFirstLaunch = [[getData objectAtIndex:5] boolValue]; //5
        _version      = [getData objectAtIndex:6]; //6

    }
    else{
        _isFirstLaunch = YES;
        _isOpenPush = YES;
        _isShowPic = NO;
        _isBellAlert_ON = NO;
        _isVibration_ON = YES;
        _push_Mode = YES;
        _version = [[Utils shareInstance] checkCurrentVersion];
       
    }
    [userDefaults synchronize];
}

@end
