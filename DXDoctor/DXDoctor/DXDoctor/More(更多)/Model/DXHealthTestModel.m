
//
//  DXHealthTestModel.m
//  DXDoctor
//
//  Created by Mask on 15/10/14.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXHealthTestModel.h"

@implementation DXHealthTestModel
- (instancetype)initWithDict:(NSDictionary *)dict{

    if ([super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)healthTestWithDict:(NSDictionary *)dict{

     return [[self alloc]initWithDict:dict];
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
