//
//  DXFamilyDrugsModel.h
//  DXDoctor
//
//  Created by Mask on 15/10/9.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXFamilyDrugsModel : NSObject
//药品Id
@property (nonatomic, strong) NSString *drugId;
//药品名称
@property (nonatomic, strong) NSString *showName;
//药品备注
@property (nonatomic, strong) NSString *remark;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)familyDrugsWithDict:(NSDictionary *)dict;
@end
