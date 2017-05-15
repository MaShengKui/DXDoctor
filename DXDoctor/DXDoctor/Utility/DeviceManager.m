//
//  DeviceManager.m
//  CloverDoctor
//
//  Created by Mask on 15-2-28.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DeviceManager.h"
//网络类型的枚举定义
typedef enum{
    NETWORK_TYPE_NONE = 0,
    NETWORK_TYPE_WIFI = 1,
    NETWORK_TYPE_3G = 2,
    NETWORK_TYPE_2G = 3,
    
}NetWORK_TYPE;
@implementation DeviceManager

//获取屏幕的尺寸
+(CGSize)currentScreenSize
{
   
    return  [UIScreen mainScreen].bounds.size;
}
//获取操作系统的版本号
+(CGFloat)currentVersion
{
    NSString *version=[UIDevice currentDevice].systemVersion;
    return [version floatValue];
}
//获取设备的型号
+(NSString*)currentModel
{
    return [UIDevice currentDevice].model;
}
#pragma mark - 获取网络类型
+(int)dataNetWorkTypeFromStatusBar{

    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subViews = [[[app valueForKey:@"statusBar"]valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    for (id subview in subViews) {
        if ([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView")class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    int netType = NETWORK_TYPE_NONE;
    NSNumber *num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    if (num == nil) {
        netType = NETWORK_TYPE_NONE;
    }else{
    
        int n = [num intValue];
        if (n == 0) {
            netType = NETWORK_TYPE_NONE;
        }else if (n == 1){
        
            netType = NETWORK_TYPE_2G;
        }else if (n == 2){
        
            netType = NETWORK_TYPE_3G;
        }else {
        
            netType = NETWORK_TYPE_WIFI;
        }
    }
    return netType;
}

@end
