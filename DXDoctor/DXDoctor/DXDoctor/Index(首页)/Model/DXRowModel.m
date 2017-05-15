//
//  DXRowModel.m
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXRowModel.h"

@implementation DXRowModel

- (instancetype)initWithDict:(NSDictionary *)dict
{

    if ([super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)modelWith:(NSDictionary *)dict{

    return [[self alloc]initWithDict:dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{


}

@end
