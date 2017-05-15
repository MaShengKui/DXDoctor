//
//  DXTruthModel.h
//  DXDoctor
//
//  Created by Mask on 15/9/26.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXTruthModel : NSObject
@property (nonatomic, copy) NSString *cover_small;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *special_id;
- (instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)truthWithDict:(NSDictionary *)dict;
@end
