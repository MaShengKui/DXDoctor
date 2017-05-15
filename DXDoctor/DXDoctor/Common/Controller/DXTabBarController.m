//
//  DXTabBarController.m
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXTabBarController.h"
#import "DXIndexController.h"
#import "DXHeathlyInfoController.h"
#import "DXMoreController.h"
#import "DXSearchController.h"
#import "DXNavigationController.h"
@interface DXTabBarController ()

@end

@implementation DXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createInit];
    
}
- (void)createInit{
    //创建首页
    [self createViewControllerWithTitle:@"首页" image:@"Icon01.png" selectedImage:@"Icon01Sel" className:[DXIndexController class]];
    //创建健康资讯
    [self createViewControllerWithTitle:@"健康科普" image:@"Icon02.png" selectedImage:@"Icon02Sel" className:[DXHeathlyInfoController class]];
    //创建家人健康
    [self createViewControllerWithTitle:@"人人搜索" image:@"Icon03.png" selectedImage:@"Icon03Sel" className:[DXSearchController class]];
    //创建更多
    [self createViewControllerWithTitle:@"更多" image:@"Icon04.png" selectedImage:@"Icon04Sel" className:[DXMoreController class]];

    [[UITabBar appearance]setTintColor:[UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:1]];
}
//创建viewcontroller的提取方法
- (void)createViewControllerWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage className:(Class)class{
    
    UIViewController *VC = [[class alloc] init];
    
    DXNavigationController *nav = [[DXNavigationController alloc] initWithRootViewController:VC];
    nav.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.title = title;
    [self addChildViewController:nav];

    
    
}


@end
