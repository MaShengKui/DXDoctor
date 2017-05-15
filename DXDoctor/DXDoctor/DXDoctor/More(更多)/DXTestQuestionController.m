//
//  DXTestQuestionController.m
//  DXDoctor
//
//  Created by Mask on 15/10/15.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXTestQuestionController.h"

@interface DXTestQuestionController ()

@end

@implementation DXTestQuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.model.title;
    [self configWebView];
}
- (void)configWebView{
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
    
    NSURL *url = [NSURL URLWithString:self.model.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
    //加载一个request
    [webView loadRequest:request];
    
    [self.view addSubview:webView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
