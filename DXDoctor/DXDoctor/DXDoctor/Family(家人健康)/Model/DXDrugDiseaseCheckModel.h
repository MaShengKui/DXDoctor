//
//  DXDrugDiseaseCheckModel.h
//  DXDoctor
//
//  Created by Mask on 15/10/11.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXDrugDiseaseCheckModel : NSObject
@property (nonatomic, strong) NSString *is_drug;
@property (nonatomic, strong) NSString *is_disease;
@property (nonatomic, strong) NSNumber *disease_id;
@property (nonatomic, strong) NSNumber *drug_id;
@property (nonatomic, strong) NSString *disease_name;
@property (nonatomic, strong) NSString *drug_common_name;
@property (nonatomic, strong) NSString *drug_name;
- (instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)drugDiseaseWithDict:(NSDictionary *)dict;
@end
