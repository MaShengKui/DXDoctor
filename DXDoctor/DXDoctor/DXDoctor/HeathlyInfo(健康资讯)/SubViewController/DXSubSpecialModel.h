//
//  DXSubSpecialModel.h
//  DXDoctor
//
//  Created by Mask on 15/9/26.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXSubSpecialModel : NSObject
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *author_avatar;
@property (nonatomic, strong) NSString *cover_small;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *special_name;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)subSpecialWithDict:(NSDictionary *)dict;
@end
