//
//  DXNewInfoModel.m
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXNewInfoModel.h"

@implementation DXNewInfoModel
- (instancetype)initWithDict:(NSDictionary *)dict{

    if ([super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.Id = dict[@"id"];
    }
    return self;
}
+(instancetype)newInfoWithDict:(NSDictionary *)dict{

    return [[self alloc]initWithDict:dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
@end
