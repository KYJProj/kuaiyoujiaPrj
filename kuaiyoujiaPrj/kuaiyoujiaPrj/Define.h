//
//  NSObject_Define.h
//  KuaiYouJia
//
//  Created by TTc on 14-9-15.
//  Copyright (c) 2014年 kuaiyoujia.com. All rights reserved.
//

/**
 *  Define.h  预定义宏
 */

/***********************************************************************/


/////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Redefine
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]

//////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - app define
// assert
#ifdef ENABLE_ASSERT_STOP
#define APP_ASSERT_STOP                     {LogRed(@"APP_ASSERT_STOP"); NSAssert1(NO, @" \n\n\n===== APP Assert. =====\n%s\n\n\n", __PRETTY_FUNCTION__);}
#define APP_ASSERT(condition)               {NSAssert(condition, @" ! Assert");}
#else
#define APP_ASSERT_STOP                     do {} while (0);
#define APP_ASSERT(condition)               do {} while (0);
#endif


//非空判断 宏
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
//当前设备的屏幕宽度
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
//当前设备的屏幕高度
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
//字符串
#define SAFE_STRING(str) ([(str) length] ? (str) : @"")

#define SearchPath	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,\
NSUserDomainMask, YES)
#define SandBoxPath(array)   (array == nil)?nil:[array objectAtIndex:0]

#define AddImage(imageName)  [[UIImageView alloc] initWithImage:\
[UIImage imageNamed:imageName]]



//当前系统的版本
#define kVersion [[[UIDevice currentDevice] systemVersion]floatValue]

//----------------------------------------------------------------------------//




