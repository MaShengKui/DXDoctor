//
//  DXParserDataManager.m
//  DXDoctor
//
//  Created by Mask on 15/10/13.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXParserDataManager.h"
@interface DXParserDataManager()

@end
@implementation DXParserDataManager
- (id)init{

    if (self == [super init]) {
        self.itemsArray = [[NSArray alloc] init];
    }
    return self;
}
+(NSArray *)parserDataWithURLByGET:(NSString *)url{

    NSArray *itemsArray = [[NSArray alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       // NSDictionary *dataDict = responseObject[@"data"];
//itemsArray = [NSArray arrayWithArray:dataDict[@"items"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"解析失败");
    }];
    return itemsArray;
}
@end
