//
//  DXDrugDiseaseCheckModel.m
//  DXDoctor
//
//  Created by Mask on 15/10/11.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXDrugDiseaseCheckModel.h"

@implementation DXDrugDiseaseCheckModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if ([super init]) {
        [self setValuesForKeysWithDictionary:dict];
        self.is_drug = [NSString stringWithFormat:@"%@", dict[@"is_drug"]];
        self.is_disease = [NSString stringWithFormat:@"%@", dict[@"is_disease"]];
    }
    return self;
}
+(instancetype)drugDiseaseWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
