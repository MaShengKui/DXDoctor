//
//  FeedBackViewController.m
//  EhmoPatient
//
//  Created by msk on 16/1/26.
//  Copyright © 2016年 LingShang Lt.Co. All rights reserved.
//

#import "FeedBackViewController.h"
#define TipString @"请输入您的宝贵意见，我们将不断进行改进"
#import "SVProgressHUD.h"
@interface FeedBackViewController ()<UITextViewDelegate>

@end

@implementation FeedBackViewController
-(void)responseLeftButton{

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"意见反馈";
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    self.feedBackTextView.layer.cornerRadius=5;
    self.submitBtn.layer.cornerRadius=5;
    self.submitBtn.backgroundColor=[UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:1];
    self.feedBackTextView.layer.borderWidth=1;
    self.feedBackTextView.layer.borderColor=[[UIColor colorWithRed:215/255.0f green:215/255.0f blue:215/255.0f alpha:1] CGColor];
    self.feedBackTextView.textAlignment=NSTextAlignmentNatural;
    self.feedBackTextView.delegate=self;
    
    // 解决输入文字不从顶部开始的bug
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.submitBtn addTarget:self action:@selector(submitFeedBackFuncClickAction:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(writeTextEndEditingFuncAction:)];
    [self.view addGestureRecognizer:tap];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 80, 30);
    [button setTitle:@"联系客服" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(responseRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
}
//结束编辑
-(void)writeTextEndEditingFuncAction:(UIGestureRecognizer *)tap{
    
    [self.view endEditing:YES];
}
-(void)responseRightButton{

    //拨打客服电话
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4006-668-888"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)submitFeedBackFuncClickAction:(id)sender {
    [self.view endEditing:YES];
    if ([TipString isEqualToString:self.feedBackTextView.text]||[self.feedBackTextView.text length]==0) {
        [SVProgressHUD showInView:self.view];
        [SVProgressHUD dismissWithError:@"请输入反馈内容"];
        return;
    }else{
    
        [SVProgressHUD showInView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismissWithSuccess:@"提交成功,感谢您的反馈"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self responseLeftButton];
            });
        });
    }
}

#pragma mark - UITextViewDelegate,用于实现placeholder的效果
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:TipString]) {
        textView.text = @"";
        textView.textColor=[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
    }
    textView.textColor=[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = TipString;
        textView.textColor=[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
    }else{
        textView.textColor=[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
