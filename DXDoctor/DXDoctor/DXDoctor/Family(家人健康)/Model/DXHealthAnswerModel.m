
//
//  DXHealthAnswerModel.m
//  DXDoctor
//
//  Created by Mask on 15/10/11.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXHealthAnswerModel.h"

@implementation DXHealthAnswerModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if ([super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.ID = dict[@"id"];
    }
    return self;
}
+(instancetype)healthAnswerWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
