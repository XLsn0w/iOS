//
//  Define.h
//  MZYY(Doctor)
//
//  Created by PengLin on 15-4-17.
//  Copyright (c) 2015年 WBQ. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Define : NSObject


#ifdef DEBUG
#define DMLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DMLog(...) do { } while (0)
#endif

//********设备属性***********
#define kDeviceVersion [[UIDevice currentDevice] systemVersion]
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES :NO)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES :NO)
#define NavigationBar_HEIGHT  self.navigationController.navigationBar.frame.size.height


#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define Pad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


//********ARC********
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

#define TY_AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

//手机型号
#define iphone5s  ([UIScreen mainScreen].bounds.size.height == 568)
#define iphone6  ([UIScreen mainScreen].bounds.size.height == 667)
#define iphone6p  ([UIScreen mainScreen].bounds.size.height == 736)
#define iphone4  ([UIScreen mainScreen].bounds.size.height == 480)
#define kDeviceModel  ([UIDevice currentDevice].model)
#define iPhone ([kDeviceModel hasPrefix:@"iPhone"])
#define iPad ([kDeviceModel hasPrefix:@"iPad"])
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]


#define DBWidth_Scale    [UIScreen mainScreen].bounds.size.width/375.0f

#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define NAVBAR_HEIGHT    64
#define TABBAR_HEIGHT    49
#define APPVERSION  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]


//***********G－C－D*************
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#pragma mark - degrees/radian functions

#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

//*******颜色************
#pragma mark - color functions

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]
#define RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define BACKGROUND_COLOR RGBCOLOR(232,246,231)
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
#define MainColor RGBCOLOR(249,80,49)
#define BgViewColor RGBCOLOR(240,240,240)
#define BQBlackColor [UIColor blackColor]
#define BQBlueColor [UIColor blueColor]
#define BQRedColor [UIColor redColor]
#define BQWhiteColor [UIColor whiteColor]
#define BQGrayColor [UIColor grayColor]
#define BQDarkGrayColor [UIColor darkGrayColor]
#define BQLightGrayColor [UIColor lightGrayColor]
#define BQGreenColor [UIColor greenColor]
#define BQCyanColor [UIColor cyanColor]
#define BQYellowColor [UIColor yellowColor]
#define BQMagentaColor [UIColor magentaColor]
#define BQOrangeColor [UIColor orangeColor]
#define BQPurpleColor [UIColor purpleColor]
#define BQBrownColor [UIColor brownColor]
#define BQClearColor [UIColor clearColor]

/** 随机色 */
#define BQRandomColor_RGB RGBCOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define BQRandomColor_RGBA RGBACOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//*******设置 view 圆角和边框************
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]


//*******多行文本size************
#define MULTILINE_TEXTSIZE(text, font, maxSize) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;


//*******文件操作***************
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//***************network message***************
#define TYTIMEOUTINTERVAL  30
#define kServiceErrorMessage  @"网络好像出了点问题～"
#define kTimeOutMessage  @"连接超时，请重新连接！"
#define kRequestFailedMessage  @"网络链接异常，请稍后再试！"
#define kRequestSuccessMessage  @"查询成功"

#define Baidu [BaiduMobStat defaultStat]
#define BaiDu_Start(str)            [[BaiduMobStat defaultStat] pageviewStartWithName:str]
#define BaiDu_End(str)              [[BaiduMobStat defaultStat] pageviewEndWithName:str]

//***************调试模式下输入NSLog，发布后不再输入***************

//调试模式下输入NSLog，发布后不再输入。
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod(fmt, ...) NSLog((@"\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);

#else
#define NSLog(...) {}
#define NSLogMethod(...) {}
#define debugLog(...)
#define debugMethod(...)
#endif

//************用户信息*********************
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#define USER_ID  [[NSUserDefaults standardUserDefaults] objectForKey:DBID]  //用户id
#define USER_TOKEN  [[NSUserDefaults standardUserDefaults] objectForKey:DBTOKEN]   //用户token
#define USER_ICON  [[NSUserDefaults standardUserDefaults] objectForKey:DBICON]   //用户头像
#define USER_NICKNAME  [[NSUserDefaults standardUserDefaults] objectForKey:DBNICKNAME]   //用户名字
#define USER_BIRTH [[NSUserDefaults standardUserDefaults] objectForKey:DBBIRTH]  //用户生日
#define USER_SEX [[NSUserDefaults standardUserDefaults] objectForKey:DBSEX]  //用户性别
#define USER_DBMONEY  [[NSUserDefaults standardUserDefaults] objectForKey:DBMONEY]  //用户夺宝币
#define USER_DBADDRESS [[NSUserDefaults standardUserDefaults] objectForKey:DBADDRESS] //用户地址
#define USER_NEWMESSAGE [[NSUserDefaults standardUserDefaults] objectForKey:DBNEWMESSAGE]  //新消息
#define USER_ALIPAYTYPE [[NSUserDefaults standardUserDefaults] objectForKey:DBAILPAYTYPE]  //支付宝的支付方式
#define USER_ALIPAYMODEL [[NSUserDefaults standardUserDefaults] objectForKey:DBAILPAYMODEL]  //支付宝的支付模型


#define DBID  @"DBID"
#define DBTOKEN @"DBTOKEN"
#define DBICON  @"DBICON"
#define DBNICKNAME @"DBNICKNAME"
#define DBSEX @"DBSEX"
#define DBMONEY @"DBMONEY"
#define DBBIRTH @"DBBIRTH"
#define DBADDRESS @"DBADDRESS"
#define DBNEWMESSAGE @"NEWDBMESSAGE"
#define DBAILPAYTYPE @"DBALIPAYTYPE"
#define DBAILPAYMODEL @"DBAILPAYMODEL"
//****************通知**********************
#define USERLOGOUT     @"userLogout"
#define USERLOGIN      @"userLogin"
#define UPDATEADDRESS   @"updateaddress"
#define UPDATEUSERINFO   @"updateuserinfo"
#define UPDATESHOPCART   @"updateshopcart"
#define UPDATEWINRECORD   @"updatewinrecord"
#define UPDATEMESSAGE     @"updatemessage"
#define USERRECHARGE      @"updatemoney"
@end
