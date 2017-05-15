//
//  DXSearchDetailController.h
//  DXDoctor
//
//  Created by Mask on 15/10/10.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXSearchDetailController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *keyWord;
@end
