//
//  DXMoreController.m
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXMoreController.h"
#import "SVProgressHUD.h"
#import "FeedBackViewController.h"
@interface DXMoreController (){

    NSInteger cleanedFielsCount;//清理掉的缓存文件个数
}
@end

@implementation DXMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self creatDataSource];
    [self creatTableView];
    
}
#pragma mark - 隐藏导航栏
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)creatUI{
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 200)];
    headerView.backgroundColor = [UIColor colorWithRed:151/255.0 green:193/255.0 blue:233/255.0 alpha:1];
    [self.view addSubview:headerView];
    
    //用户头像
    self.userHeader  = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENW-80)/2, 80, 80, 80)];
    self.userHeader.layer.cornerRadius = 40;
    self.userHeader.layer.masksToBounds = YES;
    self.userHeader.userInteractionEnabled = YES;
    self.userHeader.image = [UIImage imageNamed:@"settings_default_portrait_night.png"];
    [headerView addSubview: self.userHeader];
    
    //用户名
    self.userName = [[UILabel alloc] initWithFrame: CGRectMake((SCREENW-120)/2, 160, 120, 30)];
    self.userName.text = @"登录账号";
    self.userName.textColor = [UIColor whiteColor];
    self.userName.font = [UIFont systemFontOfSize:15];
    self.userName.userInteractionEnabled = YES;
    self.userName.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DownLoad:)];
    [self.userHeader addGestureRecognizer:tap];
    [headerView addSubview:self.userName];
    
}

#pragma mark - 第三方登录
- (void)DownLoad:(UITapGestureRecognizer *)tap{
    if (self.snsAccount != nil) {
        return;
    }
    
    //进入授权页面
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            //获取微博用户名、uid、token等
            self.snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            self.userName.text = self.snsAccount.userName;
            
            //NSLog(@"%@",snsAccount);
            [self.userHeader setImageWithURL:[NSURL URLWithString:self.snsAccount.iconURL]];
            headerView.backgroundColor = [UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:1];
        }
    });


    
}
#pragma mark - 创建数据源
- (void)creatDataSource{
    
    _dataArray = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Mine.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *dict in array) {
        
        [_dataArray addObject:dict];
    
    }
    
    
}
#pragma mark - 创建tableView
- (void)creatTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH) style:UITableViewStyleGrouped];
    tableView.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    tableView.dataSource = self;
    tableView.delegate = self;
    //隐藏垂直滚动条
    tableView.showsVerticalScrollIndicator = NO;
    tableView.tableHeaderView = headerView;
    tableView.contentInset=UIEdgeInsetsMake(-20, 0, 0, 0);
    tableView.sectionHeaderHeight=10;
    tableView.sectionFooterHeight=0;
    [self.view addSubview:tableView];
    
}

#pragma mark - UITableViewDelegate
//返回组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
    
}

//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary *dic = _dataArray[section];
    NSArray *array = dic[@"group"];
    return array.count;
    
}
//cell的复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    static NSString *identifier = @"MoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *dic = _dataArray[indexPath.section];
    NSArray *array = dic[@"group"];
    NSDictionary *dict = array[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",dict[@"image"]]];
    //添加小箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 1 && indexPath.row == 0){
        UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        newLabel.text = @"版本3.5.3";
        newLabel.font = [UIFont systemFontOfSize:12];
        newLabel.textColor  = [UIColor grayColor];
        cell.accessoryView = newLabel;
    }
    
    return cell;
}
//返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}
#pragma mark - 行点击事件
//行的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 &&indexPath.row == 0) {
        //查看我的收藏
        DXCollectionController *collection = [[DXCollectionController alloc] init];
        collection.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:collection animated:YES];
        
    }else if (indexPath.section == 0 &&indexPath.row == 1) {
        //清除缓存
        [self clear];
        
    }else if(indexPath.section == 1 && indexPath.row == 0){
         //升级
        [SVProgressHUD showInView:self.view status:@"获取版本信息中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self showAlert];
        });
        
    }else if (indexPath.section == 2 && indexPath.row == 0 ) {
        //新功能介绍
        [self pushIntroduce];
    }else if (indexPath.section == 2 &&indexPath.row == 1) {
        //意见反馈
        [self commitFeedBack];
        
    }else if (indexPath.section == 2 &&indexPath.row == 2) {
        //免责声明
        [self noResponsibility];
        
    }else if (indexPath.section == 3 && indexPath.row == 0 ) {
        //为我评价
        [self commentUs];
    }
}

-(void)commitFeedBack{

    FeedBackViewController *feedBackVC=[[FeedBackViewController alloc]init];
    feedBackVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:feedBackVC animated:YES];
}
//为我评价
-(void)commentUs{

    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/ding-xiang-yi-sheng-zhi-xin/id521635095?mt=8"]];
}
//Chat
- (void)pushChat{
    DXDoctorConsultController *chat = [[DXDoctorConsultController alloc] init];
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
    
}
//免责声明
- (void)noResponsibility{
    DXAboutAsController *about = [[DXAboutAsController alloc] init];
    about.isAboutUs=NO;
    about.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:about animated:YES];
}
//清除缓存
- (void)clear{
    
    [SVProgressHUD showInView:self.view status:@"正在清理缓存文件"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        cleanedFielsCount=files.count;
        NSLog(@"清除%d个文件",files.count);
        for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
            [SVProgressHUD dismiss];
        });
    });
    
}
-(void)clearCacheSuccess
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"清除缓存成功\n本次共清理了%d个文件",cleanedFielsCount] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
//新功能介绍
- (void)pushIntroduce{
    DXAboutAsController *about = [[DXAboutAsController alloc] init];
    about.isAboutUs=YES;
    about.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:about animated:YES];
    
}
//升级
- (void)showAlert{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"当前已是最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


@end
