//
//  DXHealthAnswerModel.h
//  DXDoctor
//
//  Created by Mask on 15/10/11.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXHealthAnswerModel : NSObject
@property (nonatomic, strong) NSNumber *article_id;
@property (nonatomic, strong) NSString *disease_name;
@property (nonatomic, strong) NSNumber *sort;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *uri;

- (instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)healthAnswerWithDict:(NSDictionary *)dict;
@end
