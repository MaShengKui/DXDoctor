//
//  AppDelegate.m
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//
#import "AppDelegate.h"
#import "GuideViewController.h"
#import "DXTabBarController.h"
#import <MAMapKit/MAMapKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   // [NSThread sleepForTimeInterval:2.0];
    //1.加载全屏window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //2.加载引导动画
    //2.1判断当前app是否是第一次运行
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstLaunch"];
        GuideViewController *guide = [[GuideViewController alloc] init];
       
        self.window.rootViewController = guide;
    }
    else{
        //进入主页
        [self createRootViewController];
        
    }
    
    //先注册当前APP成为高德地图的授权者（让这个APP获得使用高德地图的权限）
    [MAMapServices sharedServices].apiKey = @"bc41a742d358209d9242d16024d9078c";
    //友盟分享的key
    [UMSocialData setAppKey:@"55f22c6467e58ed79c000f71"];
    //设置微信的apiId   url如果为空,默认访问友盟的接口
    [UMSocialWechatHandler setWXAppId:@"wxd9a39c7122aa6516" url:nil];
    
    //设置qq的apiId及需要支持的类
    [UMSocialConfig setQQAppId:@"100424468" url:nil importClasses:@[[QQApiInterface class],[TencentOAuth class]]];
    

    return YES;
}
- (void)createRootViewController{
    DXTabBarController *tabBar = [[DXTabBarController alloc] init];
    self.window.rootViewController = tabBar;

}
#pragma mark - 第三方登录回调方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
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
