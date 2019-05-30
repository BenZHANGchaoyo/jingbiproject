//
//  AppDelegate.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "AppDelegate.h"

// controller
#import "SSKJ_BaseNavigationController.h"
#import "SSKJ_TabbarController.h"
#import "JB_Login_ViewController.h"
// 启动图（动态）
#import "WL_Launch_ViewController.h"

//中英切换
#import "SSKJLocalized.h"
// 防crash
#import "AvoidCrash.h"
// bug监控 统计
#import <Bugly/Bugly.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //点击屏幕 消失键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside=YES;
    
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder=YES;
    
    // 初始化语言
    [[SSKJLocalized sharedInstance]initLanguage];
    
    //监听token是否过期
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginToken:) name:@"LoginToken" object:nil];
    //gotoMainView
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoMainView:) name:@"gotoMainView" object:nil];
    
    //Bug 监控 统计
    [Bugly startWithAppId:Bugly_App_ID];
    // 防crash
    [self aviodCreash];

//    WL_Launch_ViewController *launchVc = [[WL_Launch_ViewController alloc]init];
//    self.window.rootViewController = launchVc;
    [self gotoMain];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)aviodCreash
{
    [AvoidCrash makeAllEffective];
    
    
    //================================================
    //   1、unrecognized selector sent to instance（方式1）
    //================================================
    
    //若出现unrecognized selector sent to instance并且控制台输出:
    //-[__NSCFConstantString initWithName:age:height:weight:]: unrecognized selector sent to instance
    //你可以将@"__NSCFConstantString"添加到如下数组中，当然，你也可以将它的父类添加到下面数组中
    //比如，对于部分字符串，继承关系如下
    //__NSCFConstantString --> __NSCFString --> NSMutableString --> NSString
    //你可以将上面四个类随意一个添加到下面的数组中，建议直接填入 NSString
    
    
    //我所开发的项目中所防止unrecognized selector sent to instance的类有下面几个，主要是防止后台数据格式错乱导致的崩溃。个人觉得若要防止后台接口数据错乱，用下面的几个类即可。
    
    NSArray *noneSelClassStrings = @[
                                     @"NSNull",
                                     @"NSNumber",
                                     @"NSString",
                                     @"NSDictionary",
                                     @"NSArray"
                                     ];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    
    
    //================================================
    //   2、unrecognized selector sent to instance（方式2）
    //================================================
    
    //若需要防止某个前缀的类的unrecognized selector sent to instance
    //比如你所开发项目中使用的类的前缀:CC、DD
    //你可以调用如下方法
    //[AvoidCrash setupNoneSelClassStringPrefixsArr:noneSelClassPrefix];
}


// 加载主视图
-(void)gotoMain
{
//    JB_Login_ViewController *vc = [[JB_Login_ViewController alloc]init];
//    self.window.rootViewController = vc;
    SSKJ_TabbarController *tabVc = [[SSKJ_TabbarController alloc]init];

    self.window.rootViewController = tabVc;
   
}
//-(void)gotoMainView:(NSNotification *)notifacation
//
//{
//
//    SSKJ_TabbarController *tabVc = [[SSKJ_TabbarController alloc]init];
//
//    self.window.rootViewController = tabVc;
//
//
//
//}

// 退出登录（单点登录被挤掉，弹出登录页面）
-(void)loginToken:(NSNotification *)notification
{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
