//
//  DXMoreController.h
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "BaseViewController.h"
#import "DXCollectionController.h"
#import "UMSocial.h"
#import "UIImageView+AFNetworking.h"
#import "DXAboutAsController.h"
@interface DXMoreController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UIView *headerView;
}
//数据源
@property (nonatomic, strong)NSMutableArray *dataArray;
//用户头像
@property (nonatomic, strong)UIImageView *userHeader;
//用户名
@property (nonatomic, strong) UILabel *userName;

@property (nonatomic, strong) UMSocialAccountEntity *snsAccount;

@end
