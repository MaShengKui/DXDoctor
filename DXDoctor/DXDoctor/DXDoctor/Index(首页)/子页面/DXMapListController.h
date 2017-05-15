//
//  DXMapListController.h
//  DXDoctor
//
//  Created by Mask on 15/10/8.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXMapListModel.h"
@interface DXMapListController : UITableViewController
@property(nonatomic, strong) void(^listBlock)(DXMapListModel *model);
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
