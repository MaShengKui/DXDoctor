//
//  DeviceManager.h
//  CloverDoctor
//
//  Created by Mask on 15-2-28.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//暴露设备的型号
@interface DeviceManager : NSObject

//获取屏幕的尺寸
+(CGSize)currentScreenSize;
//获取操作系统的版本号
+(CGFloat)currentVersion;
//获取设备的型号
+(NSString*)currentModel;

+(int)dataNetWorkTypeFromStatusBar;
@end
