//
//  AppSetMgr.h
//  kyjlandlord
//
//  Created by TTc on 15-3-9.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//
/**
 *  liutian
 */
#import <Foundation/Foundation.h>

@interface AppSetMgr : NSObject
@property (nonatomic,assign)NSInteger isShowRefreshType;
@property (nonatomic,strong)NSString *lastUpdateVersionTime;//上一次更新版本成功的时间
@property (nonatomic,strong)NSString *updateURL;   //版本更新地址
@property (nonatomic,strong)NSString *devToken;   //设备token
@property (nonatomic,strong)NSString *version;    //持久化的版本号（新版本更新需要 更新帮助页）
@property (nonatomic,assign)BOOL   isFirstLaunch; //第一次启动(帮助页)
@property (nonatomic,assign)BOOL   isForecd ;     //强制更新
@property (nonatomic,assign)BOOL   isLogin ;
@property (nonatomic,assign)BOOL   isVibration_ON;//震动提醒     YES＝打开 NO＝关闭
@property (nonatomic,assign)BOOL   isBellAlert_ON;//铃声提醒 开关 YES＝打开 NO＝关闭
@property (nonatomic,assign)BOOL   push_Mode;    //push接收模式 YES＝免打扰NO =全天
@property (nonatomic,assign)BOOL   network_ON;   //网络开关
@property (nonatomic,assign)BOOL   isOpenPush;  //推送开关
@property (nonatomic,assign)BOOL   isShowPic;   //图片开关
@property (nonatomic,assign)BOOL   wifi_ON;     //wifi开关
@property (nonatomic,assign)BOOL   isSimulator; //是否是模拟器
@property (nonatomic,strong)MBProgressHUD *HUD;

+(instancetype)shareInstance;
-(void)setupNetwork;
-(void)setupLogInfo;
-(void)setupGuideView;
-(void)ArchiveAppPro;
-(void)UnArchiveAppPro;
@end

