//
//  Utils.h
//  kyjlandlord
//
//  Created by TTc on 15-3-9.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  liutian
 */
@interface Utils : NSObject
@property (nonatomic,strong)MBProgressHUD *HUD;
+ (instancetype)shareInstance;
-(NSString *)checkCurrentVersion;
-(BOOL)checkNetWorkStatus;
-(void)configShareSDK;
-(void)checkUpdate;
-(void)takePhoneCall:(NSString *)number;
-(void)setTitle:(NSString*)title;
@end
