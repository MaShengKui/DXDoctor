//
//  DXNewInfoModel.h
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXNewInfoModel : NSObject
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *author_avatar;
@property (nonatomic, copy) NSString *author_id;
@property (nonatomic, copy) NSString *author_url;
@property (nonatomic, copy) NSString *author_remarks;
@property (nonatomic, copy) NSString *cover_small;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *publish_time;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *title;
- (instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)newInfoWithDict:(NSDictionary *)dict;
@end
