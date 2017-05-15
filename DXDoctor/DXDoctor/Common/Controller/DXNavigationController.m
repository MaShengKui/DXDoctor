//
//  DXNavigationController.m
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXNavigationController.h"

@interface DXNavigationController ()

@end

@implementation DXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //将导航栏上的字体设置成白色
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    
    //设置导航栏的背景颜色
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:1]];
}



@end
