//
//  DXRelateArticleModel.h
//  DXDoctor
//
//  Created by Mask on 15/10/11.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXRelateArticleModel : NSObject
@property (nonatomic, strong) NSString *article_title;
//图片
@property (nonatomic, strong) NSString *cover;
//小图片
@property (nonatomic, strong) NSString *cover_small;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *img_url;
@property (nonatomic, strong) NSString *search_content_hl;
- (instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)relateArticleWithDict:(NSDictionary *)dict;
@end
