//
//  DXFamilyDrugsController.h
//  DXDoctor
//
//  Created by Mask on 15/10/9.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXFamilyDrugsController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end
