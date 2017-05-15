//
//  DXScanController.h
//  DXDoctor
//
//  Created by Mask on 15/10/9.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface DXScanController : UIViewController<AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>
@property(nonatomic, strong) UIImageView *lineView;
@property (nonatomic, assign) BOOL isUp;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *layer;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end
