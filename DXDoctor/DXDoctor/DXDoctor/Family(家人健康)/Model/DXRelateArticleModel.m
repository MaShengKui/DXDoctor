
//
//  DXRelateArticleModel.m
//  DXDoctor
//
//  Created by Mask on 15/10/11.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXRelateArticleModel.h"

@implementation DXRelateArticleModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if ([super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.ID = dict[@"id"];
    }
    return self;
}
+(instancetype)relateArticleWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
