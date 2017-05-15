//
//  DXTruthModel.m
//  DXDoctor
//
//  Created by Mask on 15/9/26.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXTruthModel.h"

@implementation DXTruthModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if ([super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.Id = dict[@"id"];
    }
    return self;
}
+(instancetype)truthWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
} 
@end
