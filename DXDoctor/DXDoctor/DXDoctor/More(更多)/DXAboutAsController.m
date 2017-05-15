//
//  DXAboutAsController.m
//  DXDoctor
//
//  Created by Mask on 15/10/9.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXAboutAsController.h"

@interface DXAboutAsController ()

@end

@implementation DXAboutAsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    
    NSString *path;
    if (self.isAboutUs==YES) {
        self.navigationItem.title = @"新功能介绍";
        path = [[NSBundle mainBundle]pathForResource:@"user-manual" ofType:@"html"];
    }else{
    
        self.navigationItem.title = @"免责声明";
        path = [[NSBundle mainBundle]pathForResource:@"exeception_clause" ofType:@"html"];
    }
    NSString *htmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlStr baseURL:[NSURL fileURLWithPath:[ [NSBundle mainBundle] bundlePath]]];
}
#pragma mark -懒加载

- (UIWebView *)webView{

    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, SCREENW, SCREENH)];
        [self.view addSubview:_webView];
        _webView.scrollView.showsVerticalScrollIndicator= NO;
    }
    return _webView;
}
@end
