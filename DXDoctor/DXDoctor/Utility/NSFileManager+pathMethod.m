//
//  NSFileManager+pathMethod.m
//  CloverDoctor
//
//  Created by Mask on 15-3-1.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "NSFileManager+pathMethod.h"

@implementation NSFileManager (pathMethod)

+(BOOL)isTimeOutWithPath:(NSString *)path time:(NSTimeInterval)time{
    NSDictionary *infoDic=[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    //拿到文件的修改时间
    NSDate *fileDate=[infoDic objectForKey:NSFileModificationDate];
    NSDate *date=[NSDate date];
    NSTimeInterval currentTime=[date timeIntervalSinceDate:fileDate];
    if(currentTime>time){
        return YES;
    }else{
        return NO;
    }
}
@end
