//
//  DXMapListModel.m
//  DXDoctor
//
//  Created by Mask on 15/10/8.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXMapListModel.h"

@implementation DXMapListModel

-(NSString *)description{
    NSString * string = [NSString stringWithFormat:@"<DXMapListModel: name = %@,address = %@,distance = %d>",self.name,self.address,self.distance];
    return string;
}

@end
