//
//  DXScanController.m
//  DXDoctor
//
//  Created by Mask on 15/10/9.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXScanController.h"

@interface DXScanController (){

    NSString *string;//二维码扫描结果
}

@end

@implementation DXScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavBar];
    [self createUI];
    [self createQrCode];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_session) {
        [_session startRunning];
    }
}
-(void)configNavBar{

    self.title = @"扫一扫";
    self.navigationController.navigationBarHidden = NO;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 66, 22);
    [btn setImage:[UIImage imageNamed:@"TopBackWhite"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=item;


}
//返回按钮
-(void)btnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createUI{

    self.view.backgroundColor = [UIColor whiteColor];
    //创建扫描框
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width -  200) *0.5, (self.view.frame.size.height -  200) *0.5, 200, 200)];
    bgView.image = [UIImage imageNamed:@"HR_border"];
    [self.view addSubview:bgView];
    
    //创建扫描线
    _lineView  = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width -  200) *0.5, (self.view.frame.size.height -  200) *0.5, 200, 10)];
    _lineView.image = [UIImage imageNamed:@"HR_scan_line"];
    [self.view addSubview:_lineView];
    
    //增加动画
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(showAnim)];
    _displayLink = displayLink;
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
- (void)showAnim{
    
    CGFloat lineY = self.lineView.frame.origin.y;
    if (_isUp) {
        lineY--;
        _lineView.transform = CGAffineTransformMakeRotation(M_PI);
    }else{
        
        lineY ++;
        //取消所有的旋转
        _lineView.transform = CGAffineTransformIdentity;
        _lineView.transform = CGAffineTransformMakeRotation(0);
    }
    
    if (lineY >(self.view.frame.size.height +200) *0.5-10) {
        _isUp = YES;
    }else if (lineY<(self.view.frame.size.height -  200) *0.5){
        
        _isUp = NO;
    }
    
    self.lineView.frame =  CGRectMake((self.view.frame.size.width -  200) *0.5, lineY, 200, 10);
    
    
}
- (void)createQrCode{
    //1.拿到输入设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.设置输入
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if (error) {
        NSLog(@"未发现摄像头");
        
    }else{
        //3.设置输出
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        //3.1设置输出回调
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //4.创建会话
        _session = [[AVCaptureSession alloc] init];
        
        //4.1添加输入
        [_session addInput:input];
        //4.2添加输出
        [_session addOutput:output];
        //5.设置输入格式（扫描识别格式）
        [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeUPCECode]];
        
        // 7.增加透视层
        AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
        _layer = layer;
        
        layer.frame = self.view.bounds;
        
        [self.view.layer insertSublayer:layer atIndex:0];
        //6.开始扫描
        [_session startRunning];
        
        
    }
    
    
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects.count > 0) {
        [_session stopRunning];
        _displayLink.paused = YES;
        [_layer removeFromSuperlayer];
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects lastObject];
        string  = obj.stringValue;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:string delegate:self cancelButtonTitle:@"打开连接" otherButtonTitles:@"取消", nil];
        [alert show];
        
    }
    
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:string]];
            break;
        case 1:
            [_session startRunning];
            _displayLink.paused = NO;
            [self.view.layer insertSublayer:_layer atIndex:0];
            break;
        default:
            break;
    }
    
    
    
}


@end
