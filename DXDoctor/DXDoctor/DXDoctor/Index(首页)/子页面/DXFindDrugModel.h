//
//  DXFindDrugModel.h
//  DXDoctor
//
//  Created by Mask on 15/10/9.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXFindDrugModel : NSObject
@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSNumber *position;
@property (nonatomic, strong) NSString *descr;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)findDrugWithDict:(NSDictionary *)dict;
@end
