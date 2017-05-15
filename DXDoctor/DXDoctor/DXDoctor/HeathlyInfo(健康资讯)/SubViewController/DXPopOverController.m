//
//  DXPopOverController.m
//  DXDoctor
//
//  Created by Mask on 15/9/30.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXPopOverController.h"

@interface DXPopOverController ()
@property (nonatomic, strong) UIStepper *stepper;

@end

@implementation DXPopOverController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    
    UILabel *fontLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
    fontLabel.text = @"字体设置";
    fontLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:fontLabel];
    
   
    [self.stepper addTarget:self action:@selector(changeFont:) forControlEvents:UIControlEventValueChanged];
    
    UIView *lineView= [[UIView alloc] initWithFrame:CGRectMake(0, 85, 200, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.5;
    [self.view addSubview:lineView];
    
    
    
    UILabel *bgcolor = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 70, 30)];
    bgcolor.text = @"皮肤设置";
    bgcolor.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:bgcolor];
    
    NSArray *title = @[@"白色",@"棕褐色",@"夜间"];
    for (int i = 0; i<3; i++) {
        
        UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
        button.frame = CGRectMake(10+i*60, 130, 63, 30);
        button.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        button.layer.borderWidth = 1.0;
        button.layer.cornerRadius = 3;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.layer.masksToBounds = YES;
    
        button.tag = 2000+i;
        if (button.tag == 2000) {
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
        }else if (button.tag == 2001){
        
            [button setTitleColor:[UIColor colorWithRed:176/255.0 green:157/255.0 blue:135/255.0 alpha:1] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithRed:242/255.0 green:236/255.0 blue:210/255.0 alpha:1];
        }else{
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                button.backgroundColor = [UIColor blackColor];
        
        }
        [button setTintColor:[UIColor blackColor]];
        [button setTitle:title[i] forState:UIControlStateNormal];
        [self.view addSubview:button];
        
        [button addTarget:self action:@selector(changeSkin:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}
//设置成 自定义的字体 （12-----20）号
- (void)changeFont:(UIStepper *)stepper{

    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",stepper.value];
    [self.webView stringByEvaluatingJavaScriptFromString:str1];
    
}
- (void)changeSkin:(UIButton *)button{
    
    if (button.tag == 2000) {
        [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'black'"];
        [self.webView stringByEvaluatingJavaScriptFromString: @"document.getElementsByTagName('body')[0].style.background='#FFFFFF'"];
        
    }else if (button.tag == 2001){
    [self.webView stringByEvaluatingJavaScriptFromString: @"document.getElementsByTagName('body')[0].style.background='#F6ECD2'"];
        
    }else if(button.tag == 2002){
    
        [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'white'"];
        [self.webView stringByEvaluatingJavaScriptFromString: @"document.getElementsByTagName('body')[0].style.background='#2E2E2E'"];
    }

    
}
#pragma mark - 懒加载
- (UIStepper *)stepper{

    if (!_stepper) {
        _stepper = [[UIStepper alloc] initWithFrame:CGRectMake(10, 40, 0, 30)];
        _stepper.value = 80.0f;
        _stepper.maximumValue = 150.0f;
        _stepper.minimumValue = 60.0f;
        
        _stepper.stepValue = 10.0f;
        _stepper.continuous = YES;
         [self.view addSubview:_stepper];
    }
    return _stepper;
}



@end
