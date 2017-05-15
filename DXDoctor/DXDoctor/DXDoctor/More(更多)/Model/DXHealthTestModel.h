//
//  DXHealthTestModel.h
//  DXDoctor
//
//  Created by Mask on 15/10/14.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXHealthTestModel : NSObject
@property (nonatomic, copy) NSString *picPath;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *title;
- (instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)healthTestWithDict:(NSDictionary *)dict;
@end
