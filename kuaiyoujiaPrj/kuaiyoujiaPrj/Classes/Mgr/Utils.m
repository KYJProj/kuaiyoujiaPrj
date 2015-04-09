//
//  Utils.m
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
#import "Utils.h"

@implementation Utils

+ (instancetype)shareInstance{
    static Utils *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[Utils alloc] init];
    });
    return _sharedManager;
}
/**
 *  判断网络状态
 *
 *  @return BOOL
 */
-(BOOL)checkNetWorkStatus{
    __block BOOL network  = YES;
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN://3g
            case AFNetworkReachabilityStatusReachableViaWiFi://wifi
                network = YES;
                break;
            case AFNetworkReachabilityStatusUnknown:  //not found host
            case AFNetworkReachabilityStatusNotReachable://not network
                network = NO;
                break;
        }
    }];
    return network;
}

/**
 *  判断是模拟器
 *
 *  @return BOOL
 */
-(BOOL)isSimulator{
    static dispatch_once_t onceToken;
    __block BOOL isSimulator =  NO;
    dispatch_once(&onceToken, ^{
        NSString *model= [[UIDevice currentDevice] model];
        if ([model rangeOfString:@"Simulator"].location != NSNotFound){
            isSimulator = YES;
        }
        else{
            isSimulator = NO;
        }
    });
    return isSimulator;
}


/**
 *  调用系统拨号功能
 *
 *  @param number 电话号码
 */
-(void)takePhoneCall:(NSString *)number{
    if ([[[UIDevice currentDevice]model]isEqualToString:@"ipod touch"]||[[[UIDevice currentDevice]model]isEqualToString:@"ipad"]||[[[UIDevice currentDevice]model ]isEqualToString:@"iPhone Simulator"]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的设备不能打电话" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        NSURL *callUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",number]];
        [[UIApplication sharedApplication] openURL:callUrl];
    }
}

-(NSString *)checkCurrentVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];    //获取项目名称
//    
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];      //获取项目版本号
    
    //CFShow((__bridge CFTypeRef)(infoDictionary));
    // app名称
    //NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    //NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    //NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
}

/**
 *  版本检查
 */


-(void)checkUpdate{
    
}
/**
 *  第三方分享功能
 */
-(void)configShareSDK{
    
}

/**
 *  获取短信按钮 计算时间效果
 *
 *  @param sender UIButton对象
 */
-(void)startTime:(UIButton*)sender{
    __block int timeout=30;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }
        else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



-(NSString *)alertTextWithErrorStatus:(short)errorInfo{
    NSString *alertText =  nil;
    switch (errorInfo) {
        case SOCKET_ERROR:{
            alertText = @"Socket 链接错误";
        }
            break;
        case STATUS_CODE_OK:
        {
            alertText = @"成功";
        }
            break;
        case RESULTCODE_UNKNOW:
        {
            alertText = @"未定义的错误";
        }
            break;
        case STATUS_CODE_DUMP_RENT:
        {
            alertText = @"重复预定";
        }
            break;
        case RESULTCODE_QUERY_FAIL:
        {
            alertText = @"查询失败";
        }
            break;
        case RESULTCODE_COMMIT_FAIL:
        {
            alertText = @"提交失败";
        }
            break;
            
            
        case RESULTCODE_VERSION_FAIL:
        {
            alertText = @"新版本更新失败";
        }
            break;
        case RESULTCODE_LOGIN_FAIL:
        {
            alertText = @"未登录错误";
        }
            break;
        case RESULTCODE_SMSCODE_FAIL:
        {
            alertText = @"当日手机接收短信已达上线";
        }
            break;
        case RESULTCODE_SMSSERVER_FAIL:
        {
            alertText = @"短信服务器发送异常";
        }
            break;
            
        case RESULTCODE_PAY_FAIL:
        {
            alertText = @"账户余额不足";
        }
            break;
        case RESULTCODE_LOGIN_NAME_PASSWORD:
        {
            alertText = @"登录失败   用户名或密码有误";
        }
            break;
        case RESULTCODE_UPDATE_PASSWORD:
        {
            alertText = @"密码校验不通过";
        }
            break;
        case RESULTCODE_RESULTED:
        {
            alertText = @"手机号已被注册";
        }
            break;//
        case STATUS_CODE_HOUSE_DOWN:
        {
            alertText = @"房源已经下架";
        }
            break;
            
        case STATUS_CODE_HOUSE_UP_FAIL:
        {
            alertText = @"提取保证金错误码，房源已上架";
        }
            break;//
        case STATUS_CODE_HOUSE_NO_MAGIRE_FAIL:
        {
            alertText = @"提取保证金错误码，非保证金房源";
        }
            break;
            
        case STATUS_CODE_HOUSE_ADVED_FAIL:
        {
            alertText = @"提取保证金错误码，房源已有预约";
        }
            break;//
        case STATUS_CODE_HOUSE_NO_AUDIT_FAIL:
        {
            alertText = @"加入在线预约错误码：房源未审核";
        }
            break;
        case STATUS_CODE_HOUSE_PAYED_FAIL:
        {
            alertText = @"退出在线预约错误码：房源已支付";
        }
            break;
        default:
        {
            alertText =[NSString stringWithFormat:@"未定义的错误状态码"];
        }
            break;
    }
    return alertText;
}





//MARK:HUD
-(void)title:(NSString*)title view:(UIView*)view{
    UIView *tempView;
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
    
    for (UIWindow *window in frontToBackWindows){
        if (window.windowLevel == UIWindowLevelNormal){
            tempView = window.rootViewController.view;
            break;
        }
    }
    self.HUD = [MBProgressHUD showHUDAddedTo:tempView animated:YES];
    [tempView addSubview:self.HUD];
    self.HUD.labelText = title;
}

-(void)setTitle:(NSString*)title{
    self.HUD.labelText = title;
}
-(void)hidden:(NSString*)title{
    //是否有庶罩
    self.HUD.dimBackground = YES;
    self.HUD.labelText = title;
    [self performSelector:@selector(removeView:) withObject:title afterDelay:1];
}
-(void)removeView:(NSString*)title{
    [self.HUD hide:YES afterDelay:0];
}
@end
