//
//  HealthyCoptModel.m
//  CloverDoctor
//
//  Created by Mask on 15-3-2.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "HealthyCoptModel.h"

@implementation HealthyCoptModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //key值没找到对应的属性，会触发此方法、
    //key没有属性对应的key
    NSLog(@"undefined key:%@",key);
}

@end
