//
//  DXSpecialModel.m
//  DXDoctor
//
//  Created by Mask on 15/9/25.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXSpecialModel.h"

@implementation DXSpecialModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if ([super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.Id = dict[@"id"];
    }
    return self;
}
+(instancetype)SpecialWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
