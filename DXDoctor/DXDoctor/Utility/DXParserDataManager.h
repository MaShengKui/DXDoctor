//
//  DXParserDataManager.h
//  DXDoctor
//
//  Created by Mask on 15/10/13.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXParserDataManager : NSObject

@property (nonatomic, strong) NSArray *itemsArray;

+(NSArray *)parserDataWithURLByGET:(NSString *)url;

@end
