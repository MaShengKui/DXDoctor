//
//  DXFamilyDrugsDetailedViewController.m
//  DXDoctor
//
//  Created by msk on 16/4/18.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "DXFamilyDrugsDetailedViewController.h"
#import "SVProgressHUD.h"
#import "DBManager.h"
@interface DXFamilyDrugsDetailedViewController ()
@end

@implementation DXFamilyDrugsDetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"药品详情";
    self.navigationController.navigationBarHidden = NO;
    if (self.model) {
        self.nameTextView.text=self.model.showName;
        self.remarkTextView.text=self.model.remark;
    }
    UIButton *rightBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame=CGRectMake(0, 0, 40, 30);
    [rightBtn1 setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn1.titleLabel.font=[UIFont systemFontOfSize:15];
    [rightBtn1 addTarget:self action:@selector(rightBtn1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc] initWithCustomView:rightBtn1];
    self.navigationItem.rightBarButtonItem = item1;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(writeTextEndEditingFuncAction:)];
    [self.view addGestureRecognizer:tap];
}
//结束编辑
-(void)writeTextEndEditingFuncAction:(UIGestureRecognizer *)tap{
    
    [self.view endEditing:YES];
}
-(void)rightBtn1Clicked:(id)sender{

    [self.view endEditing:YES];
    if ([self.nameTextView.text isEqualToString:@""]) {
        [SVProgressHUD showInView:self.view];
        [SVProgressHUD dismissWithError:@"药品名称不能为空"];
        return;
    }
    if (self.model.drugId) {
        if ([[DBManager shareManager]updateDrugInfoWithDrugId:self.model.drugId showName:self.nameTextView.text remark:self.remarkTextView.text]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD showInView:self.view];
                [SVProgressHUD dismissWithSuccess:@"修改成功!"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            });
        }else{
            [SVProgressHUD showInView:self.view];
            [SVProgressHUD dismissWithSuccess:@"修改失败!"];
            return;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
