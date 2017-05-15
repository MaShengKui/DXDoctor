
//
//  DXFindDrugModel.m
//  DXDoctor
//
//  Created by Mask on 15/10/9.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXFindDrugModel.h"

@implementation DXFindDrugModel
- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self == [super init]) {
        self.descr = dict[@"description"];
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)findDrugWithDict:(NSDictionary *)dict{

 return [[self alloc]initWithDict:dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
@end
