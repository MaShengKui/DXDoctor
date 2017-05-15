//
//  DXAllDetailController.m
//  DXDoctor
//
//  Created by Mask on 15/9/26.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXAllDetailController.h"
#import "NetManager.h"
#import "SVProgressHUD.h"
#import "DeviceManager.h"
#import "DBManager.h"
#import "DXCollectionController.h"
#import "TSPopoverController.h"
#import "DXPopOverController.h"
#import "UMSocial.h"
@interface DXAllDetailController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    NSString *_htmlStr;
    BOOL _isCollectioned;
    float _textFont;
}
@property (nonatomic, strong) NSMutableString *headHtml;
@end


@implementation DXAllDetailController

- (void)viewWillAppear:(BOOL)animated{

    _isCollectioned = [[DBManager shareManager]selectFormTableWithArticleId:self.ID];
    [self configNavBar];
    //开始的字体设置为100%
    _textFont = 80.0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.ID);
    [self createWebView];
    if(_ID){
        NSString *str=[NSString stringWithFormat:k_ALLDETAIL_URL,self.ID];
        [self requestDataWithURLStr:str];
    }

}
-(void)configNavBar{
    self.title = @"详情";
    self.navigationController.navigationBarHidden = NO;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 66, 22);
    [btn setImage:[UIImage imageNamed:@"TopBackWhite"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=item;
    
    UIButton *rightBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame=CGRectMake(0, 0, 26, 26);
    [rightBtn1 setImage:[UIImage imageNamed:@"ShareIcon"] forState:UIControlStateNormal];
    [rightBtn1 setImage:[UIImage imageNamed:@"ShareIconSel"] forState:UIControlStateSelected];
    [rightBtn1 addTarget:self action:@selector(rightBtn1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc] initWithCustomView:rightBtn1];
    
    UIButton *rightBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn2.frame=CGRectMake(0, 0, 26, 26);
    [rightBtn2 setImage:[UIImage imageNamed:@"DrugIconText"] forState:UIControlStateNormal];
    [rightBtn2 addTarget:self action:@selector(showActionSheet:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn2 setImage:[UIImage imageNamed:@"DrugIconTextSel"] forState:UIControlStateSelected];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc] initWithCustomView:rightBtn2];
    
    UIButton *rightBtn3=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn3.frame=CGRectMake(0, 0, 26, 26);
    [rightBtn3 setImage:[UIImage imageNamed:@"DrugIcon04"] forState:UIControlStateNormal];
    if (_isCollectioned == YES) {
        [rightBtn3 setImage:[UIImage imageNamed:@"DrugIcon04Sel"] forState:UIControlStateNormal];
        rightBtn3.selected = YES;
    }else{
            [rightBtn3 setImage:[UIImage imageNamed:@"DrugIcon04"] forState:UIControlStateNormal];
        rightBtn3.selected = NO;
    }
    [rightBtn3 addTarget:self action:@selector(rightBtn3Clicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item3=[[UIBarButtonItem alloc] initWithCustomView:rightBtn3];
    self.navigationItem.rightBarButtonItems=@[item3,item1,item2];
    
    
}
//返回按钮
-(void)btnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
//分享按钮
-(void)rightBtn1Clicked:(UIButton*)btn{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:nil shareText:[NSString stringWithFormat:k_ALLDETAIL_URL,self.ID] shareImage:nil shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,UMShareToRenren,UMShareToDouban,UMShareToTencent,UMShareToQzone] delegate:nil];
}

//修改字体大小的
-(void) showActionSheet:(id)sender forEvent:(UIEvent*)event
{
    DXPopOverController *popViewController = [[DXPopOverController alloc] init];
    popViewController.webView = _webView;
    popViewController.view.frame = CGRectMake(100,0, 200, 200);
    popViewController.view.backgroundColor = [UIColor whiteColor];
    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:popViewController];
    
    popoverController.cornerRadius = 5;
    popoverController.titleText = @"外 观";
    popoverController.popoverBaseColor = [UIColor lightGrayColor];
    popoverController.popoverGradient= NO;
    //    popoverController.arrowPosition = TSPopoverArrowPositionHorizontal;
    [popoverController showPopoverWithTouch:event];
    
}

-(void)rightBtn3Clicked:(UIButton*)btn{

    //获取当前时间
    if (btn.selected == NO) {
        //通过开辟新的线程进行收藏功能的实现
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^{
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"收藏于 yyyy-MM-dd HH:mm:ss"];
        NSString *currentTime = [formatter stringFromDate:[NSDate date]];
            
        NSData *data;
        if (self.coverData==nil) {
            data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.cover_small]];
        }else{
        
            data=self.coverData;
        }
        
        [[DBManager shareManager]insertArticleWithArticleId:self.ID imageData:data articleTitle:self.article WithOthers:currentTime];
            btn.selected = YES;
        }];
        [queue addOperation:block];
        [btn setImage:[UIImage imageNamed:@"DrugIcon04Sel"] forState:UIControlStateNormal];
        
    }else{
    
        [[DBManager shareManager]deleteArticleWithArticleId:self.ID];
        [btn setImage:[UIImage imageNamed:@"DrugIcon04"] forState:UIControlStateNormal];
        btn.selected = NO;
    }
   
}

-(void)loadDataWithUrlString:(NSString*)urlString{
    
    NSString *str = urlString;
    
    self.headHtml = [NSMutableString string];
    
    [self.headHtml appendString:@"<!doctype html><html>"];
    
    [self.headHtml appendString:@"<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>"];
    [self.headHtml appendString:@"<meta content='width=device-width, minimum-scale=1.0, maximum-scale=1.0' name='viewport'>"];
      //(initial-scale是初始缩放比,minimum-scale=1.0最小缩放比,maximum-scale=5.0最大缩放比,user-scalable=yes是否支持缩放)
    [self.headHtml appendString:[NSString stringWithFormat:@"<style type='text/css'>img{max-width:%gpx}</style>",[UIScreen mainScreen].bounds.size.width-15]];
    
    
    [self.headHtml appendString:@"<body>"];
    
    [self.headHtml appendString:str];
    
    NSMutableString *footHTML = [NSMutableString string];
    
    [footHTML appendString:@"</body></html>"];
    
    [self.headHtml appendString:footHTML];
    
    
    [_webView loadHTMLString:self.headHtml baseURL:nil];
    
}
//创建webView
-(void)createWebView{
    self.automaticallyAdjustsScrollViewInsets=NO;
    _webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64)];
    _webView.delegate=self;
    _webView.scalesPageToFit=YES;
    [self.view addSubview:_webView];
}
//网络请求
-(void)requestDataWithURLStr:(NSString*)urlString{
    //在子线程中进行网络的请求和数据的解析  解析完成后 会到主页面进行加载 可以使主页面加载的速度更快
    [NetManager requestWithString:urlString finished:^(id responseObj) {
        
        [self prepareData:responseObj];
        
        
        [_webView reload];
    } failed:^(NSString *errorMsg) {
        
    }];
}
-(void)prepareData:(id)responseObj{
    NSDictionary *dict=[responseObj objectForKey:@"data"];
    NSArray *array=[dict objectForKey:@"items"];
    NSDictionary *lastDic=[array lastObject];
    _htmlStr=lastDic[@"content"];
    if(_htmlStr){
        [self loadDataWithUrlString:_htmlStr];
    }
    
}
#pragma mark - UIWebViewDelegate
//webView开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //能够显示提示文字的加载等待控件
    [SVProgressHUD showInView:self.view status:@"加载中"];
}
//webView结束加载
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '80%'"];
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
}



@end
