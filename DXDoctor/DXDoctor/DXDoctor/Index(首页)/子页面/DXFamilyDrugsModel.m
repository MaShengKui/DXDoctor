//
//  DXFamilyDrugsModel.m
//  DXDoctor
//
//  Created by Mask on 15/10/9.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXFamilyDrugsModel.h"

@implementation DXFamilyDrugsModel
- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self =[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)familyDrugsWithDict:(NSDictionary *)dict{

   return  [[self alloc] initWithDict:dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
@end
