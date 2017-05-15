//
//  DXIndexController.m
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXIndexController.h"
#import "DXHealthTestController.h"
#import "DXDoctorConsultController.h"
@interface DXIndexController ()
//组数
@property (nonatomic, strong) NSArray *groups;
@end

@implementation DXIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
}
- (void)createUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor=[UIColor whiteColor];
    CGFloat ViewW =  SCREENW / 3;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH - ViewW*2-64-49)];
    headerView.backgroundColor = [UIColor colorWithRed:20/255.0f green:175/255.0f blue:92/255.0f alpha:1];
    [self.view addSubview:headerView];
    
    //LOGO的标志
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENW - 110)/2, (headerView.frame.size.height - 130)/2, 110, 110)];
    imageView.image = [UIImage imageNamed:@"IndexLogoHD-1"];
    [headerView addSubview:imageView];
    
    
    //按钮的创建
    for (int i = 0; i<6; i++) {
        NSDictionary *dict = self.groups[i];
        
        UIView *buttonBgView = [[UIView alloc] initWithFrame:CGRectMake(i%3*ViewW+1,headerView.frame.size.height+i/3 *(ViewW)+65, ViewW-2, ViewW-2)];
        [self.view addSubview:buttonBgView];
        buttonBgView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, ViewW, 60);
        [button setImage: [UIImage imageNamed:dict[@"icon"]] forState:UIControlStateNormal];
        button.tag = 3000+i;
        [button addTarget:self action:@selector(IndexChange:) forControlEvents:UIControlEventTouchUpInside];
        [buttonBgView addSubview:button];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, buttonBgView.frame.size.width, 20)];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = dict[@"title"];
        [buttonBgView addSubview:titleLabel];
    }
    
    //创建广告标语
    UILabel *ADLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, headerView.frame.size.height - 30, SCREENW-60, 20)];
    ADLabel.text = @"万物之中 希望至美， 至美之物 永不凋零";
    ADLabel.textAlignment = NSTextAlignmentCenter;
    ADLabel.textColor = [UIColor whiteColor];
    ADLabel.font = [UIFont boldSystemFontOfSize:14];
    [headerView addSubview:ADLabel];
    
    
}
- (void)pushSearch{
    
    DXSearchController *search = [[DXSearchController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

//页面跳转的点击事件
- (void)IndexChange:(UIButton *)button{
    if (button.tag == 3000) {
        //对症找药
        DXFindDrugController *findDrug = [[DXFindDrugController alloc] init];
         findDrug.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:findDrug animated:YES];
    }else if (button.tag == 3001){
        //家庭药箱
        DXFamilyDrugsController *familyDrug = [[DXFamilyDrugsController alloc] init];
        familyDrug.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:familyDrug animated:YES];
    }else if (button.tag == 3002){
        //健康测评
        DXHealthTestController *healthTextVC = [[DXHealthTestController alloc] init];
        healthTextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:healthTextVC animated:YES];
        
    }else if (button.tag == 3003){
        //附近药店
        DXNearMedicineShopController *nearShop = [[DXNearMedicineShopController alloc] init];
        nearShop.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nearShop animated:YES];
    }else if (button.tag == 3004){
        //扫一扫
        DXScanController *scan = [[DXScanController alloc] init];
        scan.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:scan animated:YES];
        
    }else if (button.tag == 3005){
        //用药咨询
        DXDoctorConsultController *consultVC = [[DXDoctorConsultController alloc] init];
        consultVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:consultVC animated:YES];
        
    }
    
    
}
//存储数据的数组
- (NSArray *)groups{
    
    if (!_groups) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Index.plist" ofType:nil];
        _groups = [NSArray arrayWithContentsOfFile:path];
    }
    return _groups;
}



@end
