//
//  DXHeathlyInfoController.m
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXHeathlyInfoController.h"
#import "AFNetworking.h"
#import "DXNewInfoModel.h"
#import "DXNewInfoCell.h"
#import "MJRefresh.h"
#import "DXSpecialCell.h"
#import "DXAddCategoryController.h"
#import "DXSpecialViewController.h"
#import "DXTruthModel.h"
#import "DXSubSpecialCell.h"
#import "DXAllDetailController.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"
@interface DXHeathlyInfoController (){

    //刷新初入的页数
    NSInteger _page;
    
//    UIView *bgView;
}

//记录点击的button
@property (nonatomic, strong) UIButton *selectedButton;
//小图片
@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UITableView *tableView;
//传入解析数据的参数
@property (nonatomic, copy) NSString *InfoCagegory;
//存放数据源的数组
@property (nonatomic, strong) NSMutableArray *dataArray;
//存放返回来的频道列表
@property (nonatomic, strong) NSMutableArray *categoryArray;
@property (nonatomic, strong) UIView *centerView;


@end

@implementation DXHeathlyInfoController

//-(void)viewWillAppear:(BOOL)animated{
//
//    [super viewWillAppear:animated];
//    for (UIView *view in self.view.subviews) {
//        if (view==bgView) {
//            [bgView removeFromSuperview];
//        }
//        if (self.centerView) {
//            [self.centerView removeFromSuperview];
//        }
//    }
//    _dataArray = [[NSMutableArray alloc] init];
//    self.InfoCagegory = @"article";
//    _page = 1;
//    [self createDataSource];
//    [self createUI];
//
//}
- (void)viewDidLoad {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataArray = [[NSMutableArray alloc] init];
    self.InfoCagegory = @"article";
    [super viewDidLoad];
    self.categoryArray = [NSMutableArray arrayWithObjects:@"最新资讯", @"健康专题", @"真相", nil];
    _page = 1;
    [self createDataSource];
    [self createUI];
    [self createTableView];
    [self createRefresh];
    [self createNaviagtionCustom];
    
}
- (void)createRefresh{
    
    [self.tableView addFooterWithTarget:self action:@selector(pushRefresh)];
    
}
- (void)pushRefresh{
    
    _page ++;
    NSLog(@"%d", _page);
    if ([self.InfoCagegory isEqualToString:@"truth"]) {
        [self createTruthDataSource];
    }else if([self.InfoCagegory isEqualToString:@"article"]||[self.InfoCagegory isEqualToString:@"special"]){
        [self createDataSource];
    }else{
        
        [self createOtherDataSource];
    }
    
    
    [self.tableView footerEndRefreshing];
}
#pragma mark - 创建导航栏的右边按钮
/**
 创建导航栏的右边按钮
 */
- (void)createNaviagtionCustom{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 30, 30);
    button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MedTopAdd"]];
    [button addTarget:self action:@selector(addCategory) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
    
}
//添加类别
- (void)addCategory{

    DXAddCategoryController *add = [[DXAddCategoryController alloc] init];
    add.hidesBottomBarWhenPushed = YES;
    add.cagoryArray = self.categoryArray;
    [self.navigationController pushViewController:add animated:YES];
    add.addCategoryBlock = ^(NSMutableArray * categoryName){
        self.categoryArray = [NSMutableArray arrayWithObjects:@"最新资讯", @"健康专题", @"真相", nil];
        for (NSString *str in categoryName) {
            for (NSString *str1 in self.categoryArray) {
                if ([str isEqualToString:str1]) {
                    return ;
                }
            }
//            NSLog(@"%@", str);
            
            [_categoryArray addObject:str];
        }
        [self.centerView removeFromSuperview];
//        self.InfoCagegory = @"article";
//        [self createDataSource];
        [self createUI];
       
        
    };
   
    
}
- (void)createUI{
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENW, 40)];
    self.centerView.alpha = 0.4;
    self.centerView.userInteractionEnabled = YES;
    self.centerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.centerView];
    CGFloat btnW = SCREENW / self.categoryArray.count;
    for (int  i = 0; i<self.categoryArray.count; i++) {
        //循环创建button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake(i * btnW, 10, btnW - 1, 20);
        [button setTitle:self.categoryArray[i] forState:UIControlStateNormal];
        [button setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(changeInfo:) forControlEvents:UIControlEventTouchUpInside];
       
        button.tag = 1000+i;
        if (button.tag == 1000) {
            button.selected = YES;
            self.selectedButton = button;
        }
        if (_categoryArray.count>3&&_categoryArray.count<6) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        }else{
        
             button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        }
        button.exclusiveTouch=YES;
        [self.centerView addSubview:button];
        //循环创建小竖线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i*btnW-2, 10, 1, 20)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.centerView addSubview:lineView];
        
        
    }
   self.iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
   self.iconButton.frame = CGRectMake((btnW-14)/2-2, 40-5, 14, 7);
   self.iconButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BlackUpArrow"]];
    [self.centerView addSubview:self.iconButton];

    
}
- (void)changeInfo:(UIButton *)button{
    //移动滑块
    [UIView animateWithDuration:0.5 animations:^{
        self.iconButton.frame = CGRectMake((button.frame.size.width /2)+(button.tag - 1000)*(button.frame.size.width), 40-5, 14, 7);
    }];
    //点击按钮响应事件
    button.selected = YES;
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    
    //点击传入参数进行数据解析
     _page = 1;
    [_dataArray removeAllObjects];
    if (button.tag == 1000) {
         self.InfoCagegory = @"article";
        [self createDataSource];
    }else if (button.tag == 1001) {
        self.InfoCagegory = @"special";
        [self createDataSource];
    }else if(button.tag == 1002) {
        self.InfoCagegory = @"truth";
        [self createTruthDataSource];
        
    }else if([button.titleLabel.text isEqualToString:@"母婴"]){
        self.InfoCagegory = @"MY";
        [self createOtherDataSource];
    }else if([button.titleLabel.text isEqualToString:@"营养"]){
        self.InfoCagegory = @"YY";
          [self createOtherDataSource];
    }else if([button.titleLabel.text isEqualToString:@"慢病"]){
        self.InfoCagegory = @"MB";
          [self createOtherDataSource];
    }else if([button.titleLabel.text isEqualToString:@"肿瘤"]){
        self.InfoCagegory = @"ZL";
          [self createOtherDataSource];
    }
}
//创建最新资讯和健康专题页面的数据源
- (void)createDataSource{
    [SVProgressHUD showInView:self.view status:@"加载中"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:k_NEWINFO_URL,self.InfoCagegory,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        NSDictionary *dataDic = responseObject[@"data"];
        NSArray *data = dataDic[@"items"];
        
        for (NSDictionary *itemDict in data) {
            if ([self.InfoCagegory isEqualToString:@"article"]) {
                DXNewInfoModel *model = [DXNewInfoModel newInfoWithDict:itemDict];
                [_dataArray addObject:model];
            }else{
                
                DXSpecialModel *model = [DXSpecialModel SpecialWithDict:itemDict];
                [_dataArray addObject:model];
            }
            
        }
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            [self.tableView reloadData];
            self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
            self.navigationItem.rightBarButtonItem=nil;
            return;
        }
    }];
}

//创建真相页面的数据源
- (void)createTruthDataSource{

    [SVProgressHUD showInView:self.view status:@"加载中"];
    NSURL *url  = [NSURL URLWithString:[NSString stringWithFormat:k_TRUTH_URL,_page]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data==nil) {
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.tableView reloadData];
        self.navigationItem.rightBarButtonItem=nil;
        return;
    }
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dict = rootDict[@"data"];
    
    for (NSDictionary *itemDict in dict[@"items"]) {
        DXTruthModel *model = [DXTruthModel truthWithDict:itemDict];
        [_dataArray addObject:model];
        
    }
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
    
}
//创建（母婴、慢病、营养、肿瘤）页面的数据源
- (void)createOtherDataSource{
    [SVProgressHUD showInView:self.view status:@"加载中"];
    NSString *tager;
    if ([self.InfoCagegory isEqualToString:@"MY"]) {
        tager = @"5";
    }else if ([self.InfoCagegory isEqualToString:@"YY"]){
        tager = @"6";
    }
    else if ([self.InfoCagegory isEqualToString:@"MB"]){
        tager = @"7";
    }
    else if ([self.InfoCagegory isEqualToString:@"ZL"]){
        tager = @"8";
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:k_OTHER_URL,tager,_page] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dataDic = responseObject[@"data"];
        NSArray *data = dataDic[@"items"];
        
        for (NSDictionary *itemDict in data) {
            DXNewInfoModel *model = [DXNewInfoModel newInfoWithDict:itemDict];
            [_dataArray addObject:model];
            
        }
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       [self.tableView reloadData];
    }];
    
}

- (void)createTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
#pragma mark - UITableViewDelegate
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}
//自定义tableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (_dataArray.count==0) {
        return nil;
    }else{
    
        if ([self.InfoCagegory isEqualToString:@"article"]) {
            DXNewInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"DXNewInfoCell" owner:self options:nil]lastObject];
            }
            cell.backgroundColor = [UIColor clearColor];
            DXNewInfoModel *model = _dataArray[indexPath.row];
            cell.model = model;
            return cell;
        }else if([self.InfoCagegory isEqualToString:@"special"]){
            DXSpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpecialCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"DXSpecialCell" owner:self options:nil]lastObject];
            }
            cell.backgroundColor = [UIColor clearColor];
            DXSpecialModel *model = _dataArray[indexPath.row];
            cell.model = model;
            return cell;
        }else if([self.InfoCagegory isEqualToString:@"truth"]){
            DXSubSpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subSpecialCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"DXSubSpecialCell" owner:self options:nil]lastObject];
            }
            cell.backgroundColor = [UIColor clearColor];
            DXTruthModel *model = _dataArray[indexPath.row];
            cell.truthModel = model;
            return cell;
        }else if([self.InfoCagegory isEqualToString:@"MY"]||[self.InfoCagegory isEqualToString:@"YY"]||[self.InfoCagegory isEqualToString:@"MB"]||[self.InfoCagegory isEqualToString:@"ZL"]){
            
            DXNewInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"DXNewInfoCell" owner:self options:nil]lastObject];
            }
            cell.backgroundColor = [UIColor clearColor];
            DXNewInfoModel *model = _dataArray[indexPath.row];
            cell.model = model;
            return cell;
            
        }else{
            
            return nil;
        }
    }
}
//行的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DXAllDetailController *detail = [[DXAllDetailController alloc] init];
    if ([self.InfoCagegory isEqualToString:@"special"]) {
    
        DXSpecialViewController *special = [[DXSpecialViewController alloc] init];
        DXSpecialModel *model = self.dataArray[indexPath.row];
        special.model = model;
        special.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:special animated:YES];
    }else if([self.InfoCagegory isEqualToString:@"article"]){
    
        DXNewInfoModel *model = self.dataArray[indexPath.row];
        detail.ID = model.Id;
        detail.article = model.title;
        detail.cover_small = model.cover_small;
        detail.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        DXTruthModel *model = self.dataArray [indexPath.row];
        detail.ID = model.Id;
        detail.article = model.title;
        detail.cover_small = model.cover_small;
        detail.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
    
}
//设置tableViewde 每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 115;
}


#pragma mark - 懒加载
- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, SCREENW, SCREENH -104-49) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:239/255.0 blue:238/255.0 alpha:1];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
//-(void)viewDidDisappear:(BOOL)animated{
//
//    [super viewDidDisappear:animated];
//    for (UIView *view in self.view.subviews) {
//        if (view==bgView) {
//            [bgView removeFromSuperview];
//            [self createNaviagtionCustom];
//        }
//    }
//    [self.centerView removeFromSuperview];
//}

@end
