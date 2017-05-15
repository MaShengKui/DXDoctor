//
//  DXFindDrugController.h
//  DXDoctor
//
//  Created by Mask on 15/10/5.
//  Copyright (c) 2015年 Mask. All rights reserved.
//


/*对症找药*/
#import <UIKit/UIKit.h>
#import "DXFindDrugModel.h"
#import "DXFindDrugCell.h"
@interface DXFindDrugController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
