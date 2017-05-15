//
//  DXQuestionAnswerModel.h
//  DXDoctor
//
//  Created by Mask on 15/10/13.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXQuestionAnswerModel : NSObject
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *disease_name;
@property (nonatomic,strong) NSNumber *sort;
@property (nonatomic,strong) NSNumber *Id;
@property (nonatomic,strong) NSNumber *article_id;
- (instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)questionAnswerWithDict:(NSDictionary *)dict;
@end
