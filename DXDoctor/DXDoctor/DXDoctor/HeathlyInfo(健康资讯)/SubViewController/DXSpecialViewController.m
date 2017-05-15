//
//  DXSpecialViewController.m
//  DXDoctor
//
//  Created by Mask on 15/9/26.
//  Copyright (c) 2015年 Mask. All rights reserved.
//
                /**专题页面详细一级页面**/
#import "DXSpecialViewController.h"
#import "AFNetworking.h"
#import "DXSubSpecialModel.h"
#import "DXSubSpecialCell.h"
#import "DeviceManager.h"
#import "DXAllDetailController.h"
#import "UMSocial.h"
@interface DXSpecialViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation DXSpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专题";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNaviagtionCustom];
    NSLog(@"%@", self.model.Id);
    [self createDataSource];
    int netType =  [DeviceManager dataNetWorkTypeFromStatusBar];
    if (netType == 0) {
        NSLog(@"NONE");
    }else if (netType == 1){
    
        NSLog(@"2G网络");
    }else if (netType == 2){
    
        NSLog(@"3G");
    }else {
    
        NSLog(@"WIFI");
    }
   
    
}


#pragma mark - 创建导航栏的右边按钮
/**
 创建导航栏的右边按钮
 */
- (void)createNaviagtionCustom{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"ShareIcon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ShareIconSel"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(Share) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
    
}
#pragma mark - 分享功能的设置
/**分享功能的设置*/
- (void)Share{

    [UMSocialSnsService presentSnsIconSheetView:self appKey:nil shareText:k_SHARE_RUL shareImage:nil shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,UMShareToRenren,UMShareToDouban,UMShareToTencent,UMShareToQzone] delegate:nil];
}
- (void)configTableView{

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
#pragma mark - 创建数据源
/**
 创建数据源
 */
- (void)createDataSource{
    
 
    _dataArray = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:K_HEATH_DETAIL_URL, self.model.Id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dataDic = responseObject[@"data"];
        NSArray *itemsArray = dataDic[@"items"];
        for (NSDictionary *itemDict in itemsArray) {
            DXSubSpecialModel *model = [DXSubSpecialModel subSpecialWithDict:itemDict];
            [_dataArray addObject:model];
        }
        [self configTableView];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"解析失败");
    }];
    
    
}
#pragma mark - tableView的代理方法
//返回有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}
//自定义的tableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifer = @"subSpecialCell";
    DXSubSpecialCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DXSubSpecialCell" owner:self options:nil] lastObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    DXSubSpecialModel *model = _dataArray[indexPath.row];
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.model = model;
    return cell;
    
    
}
//返回cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
//返回header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 80;
}
//自定义tableview的header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENW - 40, 80)];
    view.backgroundColor = [UIColor colorWithRed:231/255.0 green:239/255.0 blue:238/255.0 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, view.frame.size.width, 20)];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = self.model.name;
    [view addSubview:titleLabel];
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, view.frame.size.width, 60)];
    desLabel.font = [UIFont systemFontOfSize:13];
    desLabel.textColor =[UIColor grayColor];
    desLabel.numberOfLines = 2;
    desLabel.text = self.model.desc;
    [view addSubview:desLabel];
    return view;
    
}
//行的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DXAllDetailController *detail = [[DXAllDetailController alloc] init];
    DXSubSpecialModel *model = self.dataArray[indexPath.row];
    detail.ID = model.Id;
    detail.article = model.title;
    detail.cover_small = model.cover_small;
    [self.navigationController pushViewController:detail  animated:YES];

}

#pragma mark - 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREENW , SCREENH ) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
   
}


@end
