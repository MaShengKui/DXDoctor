//
//  NSFileManager+pathMethod.h
//  CloverDoctor
//
//  Created by Mask on 15-3-1.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

//项目中，我们经常需要定义NSFileManager的类别
@interface NSFileManager (pathMethod)

//判断指定路径下的文件是否超出了规定时间
//NSTimeInterval double类型 指多少秒
+(BOOL)isTimeOutWithPath:(NSString*)path time:(NSTimeInterval)time;

@end
