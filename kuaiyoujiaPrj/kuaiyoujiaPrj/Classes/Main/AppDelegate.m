//
//  AppDelegate.m
//  kyjlandlord
//
//  Created by TTc on 15-3-5.
//  Copyright (c) 2015年 北京快有家网络科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "NavViewController.h"
#import "Utils.h"
#import "AppSetMgr.h"
#import "HomeVC.h"
#import "TTIntroView.h"
#import "GudieVC.h"
@interface AppDelegate ()<TTIntroDelegate>

@end

@implementation AppDelegate


+(AppDelegate*)shareInstance{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSString * currentVersion = [[Utils shareInstance] checkCurrentVersion];
    AppSetMgr *app = [AppSetMgr shareInstance];
    [app UnArchiveAppPro];
    if(app.isFirstLaunch || ([app.version floatValue] != [currentVersion floatValue])){
        GudieVC *VC = [[GudieVC alloc]init];
        self.window.rootViewController = VC;
        app.isFirstLaunch = NO;
    }else{
        [self showViewController];
    }
    [app ArchiveAppPro];
    [app setupLogInfo];
    [app setupNetwork];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)showViewController{
    HomeVC *VC = [[HomeVC alloc]init];
    NavViewController *navController = [[NavViewController alloc]initWithRootViewController:VC];
    self.window.rootViewController = navController;

}


- (void)introDidFinish {
    [self showViewController];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
