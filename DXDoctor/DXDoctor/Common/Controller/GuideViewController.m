//
//  GuideViewController.m
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"
#import "DXTabBarController.h"
#import "DBManager.h"
@interface GuideViewController ()<UIScrollViewDelegate>
//引导页的scrollView
@property (nonatomic, strong) UIScrollView *scrollView;
//存储图片的imageView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *DrugsArray;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
   
}
- (void)createUI{
    for (int i = 1; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i - 1) * SCREENW, 0, SCREENW, SCREENH)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"intro_%d.jpg", i]];
        imageView.backgroundColor = [UIColor orangeColor];
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        
        if (i == 3) {
            //给第三张图片添加点击的手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enterMainView)];
            [imageView addGestureRecognizer:tap];
        }
    }
   
    
}
- (void)enterMainView{
    DXTabBarController *tabbar = [[DXTabBarController alloc] init];
    [self.scrollView removeFromSuperview];tabbar.view.alpha = 0.0;
    [UIView animateWithDuration:2.0 animations:^{
       tabbar.view.alpha = 1.0;
    [self presentViewController:tabbar animated:YES completion:^{
        
    }];
        
    }];
    for (NSDictionary *itemsDict in self.DrugsArray) {
        
        [[DBManager shareManager]insertDrugWithDrugId:itemsDict[@"drugId"] showName:itemsDict[@"showName"] remark:itemsDict[@"remark"]];
    }
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView{

    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(SCREENW * 3, SCREENH);
        _scrollView.contentOffset = CGPointZero;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
        
    }
    return _scrollView;
    
}

- (NSArray *)DrugsArray{
    
    if (!_DrugsArray) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"StandingDrugs" ofType:@"plist"];
        _DrugsArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _DrugsArray;
}
@end
