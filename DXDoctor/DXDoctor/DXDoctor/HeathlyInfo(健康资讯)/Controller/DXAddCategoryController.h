//
//  DXAddCategoryController.h
//  DXDoctor
//
//  Created by Mask on 15/9/25.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "BaseViewController.h"

@interface DXAddCategoryController : BaseViewController
@property (nonatomic, copy)void (^addCategoryBlock )(NSMutableArray *category);
@property (nonatomic, strong) NSArray *cagoryArray;
@end
