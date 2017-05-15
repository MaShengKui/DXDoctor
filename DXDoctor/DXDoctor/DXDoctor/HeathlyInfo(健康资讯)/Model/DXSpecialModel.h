//
//  DXSpecialModel.h
//  DXDoctor
//
//  Created by Mask on 15/9/25.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXSpecialModel : NSObject
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *cover_small;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *author_remarks;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *modify_time;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *type_name;
- (instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)SpecialWithDict:(NSDictionary *)dict;
@end
