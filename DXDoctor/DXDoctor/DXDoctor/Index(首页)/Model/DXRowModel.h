//
//  DXRowModel.h
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXRowModel : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *des;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWith:(NSDictionary *)dict;
@end
