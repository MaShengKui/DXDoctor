//
//  NetManager.h
//  CloverDoctor
//
//  Created by Mask on 15-3-1.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

//用于封装网络交互的操作
//网络请求用AFNetWorking
typedef void (^DownloadFinishedBlock)(id responseObj);
typedef void (^DownloadFailedBlock)(NSString *errorMsg);

@interface NetManager : NSObject
//http协议，get请求
+(void)requestWithString:(NSString*)urlString finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock;
//http协议，post请求
+ (void)afPostRequestWithUrlString:(NSString *)urlString parms:(NSDictionary *)dic finishedBlock:(DownloadFinishedBlock)finishedBlock failedBlock:(DownloadFailedBlock)failedBlock;
@end
