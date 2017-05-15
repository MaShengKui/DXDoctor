//
//  DXFavoriteModel.h
//  DXDoctor
//
//  Created by Mask on 15/9/27.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXFavoriteModel : NSObject
@property (nonatomic, strong) NSString *articleId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSData *coverData;
@property (nonatomic, strong) NSString *other;
@end
