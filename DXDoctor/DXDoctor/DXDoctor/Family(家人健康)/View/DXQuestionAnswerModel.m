//
//  DXQuestionAnswerModel.m
//  DXDoctor
//
//  Created by Mask on 15/10/13.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXQuestionAnswerModel.h"

@implementation DXQuestionAnswerModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if ([super init]) {
        self.Id = dict[@"id"];
        self.title = dict[@"title"];
        self.sort = dict[@"sort"];
        self.disease_name = dict[@"disease_name"];
        self.article_id = dict[@"article_id"];
        NSArray *answersArr = dict[@"answers"];
        for (NSDictionary *conDict in answersArr) {
            self.content = conDict[@"content"];
            
        }
    }
    return self;
}
+(instancetype)questionAnswerWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}
@end
