//
//  DXMapListModel.h
//  DXDoctor
//
//  Created by Mask on 15/10/8.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXMapListModel : NSObject
//        NSLog(@"位置为:经度%f,纬度%f,名称:%@,地址:%@", p.location.longitude,p.location.latitude,p.name,p.address);
//NSLog(@"%ld, %@", p.distance,p.tel);

@property (nonatomic, assign) float latitude;//纬度
@property (nonatomic, assign) float longitude;//经度

@property (nonatomic, strong) NSString *name;//名称
@property (nonatomic, strong) NSString *address;//地址

@property (nonatomic, assign) NSInteger distance;//距离

@end
