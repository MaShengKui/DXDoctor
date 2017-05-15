//
//  DXSearchController.m
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXSearchController.h"
#import "AFNetworking.h"
#import "DXSearchDetailController.h"
@interface DXSearchController ()<UITableViewDataSource, UITableViewDelegate>{

    UIView *bgView;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation DXSearchController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    for (UIView *view in self.view.subviews) {
        if (view==bgView) {
            [view removeFromSuperview];
        }
    }
    [self createDataSource];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)createUI{
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightbtn.frame = CGRectMake(0, 0, 30, 30);
    rightbtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = right;
    
    //[rightbtn addTarget:self action:@selector(callBack) forControlEvents:UIControlEventTouchUpInside];
}
/**
 创建数据源
 */
- (void)createDataSource{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"人人搜索";
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    _dataArray = [[NSMutableArray alloc] init];
    
    //解析数据
    NSURL *url = [NSURL URLWithString:k_FAMILYDRUGS_URL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if (data==nil) {
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64)];
        bgView.backgroundColor=[UIColor colorWithRed:245/255.0f green:246/255.0f blue:247/255.0f alpha:1];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake((SCREENW-55)*0.5, 150, 55, 55)];
        imgView.image=[UIImage imageNamed:@"icon-wuneirong@3x"];
        [bgView addSubview:imgView];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake((SCREENW-150)*0.49, 215, 150, 20)];
        label.text=@"网络异常，请检查网络设置";
        label.font=[UIFont systemFontOfSize:12];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1];
        [bgView addSubview:label];
        [self.view addSubview:bgView];
        return;
    }

    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDict = dict[@"data"];
    NSArray *itemArray = dataDict[@"items"];
    for (NSDictionary *dict in itemArray) {
        [self.dataArray addObject:dict];
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 10;
        
    }else{
        return 0;
    }
    
}
//cell的复用-
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.dataArray.count==0) {
        return nil;
    }
    static NSString *identifier = @"findDrugCell";
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"findDrugCell1"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"findDrugCell12"];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        //创建View
        NSArray *array = @[@"疾病", @"医院", @"药品", @"文章", @"医生", @"问答"];
        CGFloat contentW = (SCREENW -90)/6;
        for (int i = 0; i<6; i++) {
            UIView *contentBg = [[UIView alloc] initWithFrame:CGRectMake(40+i*contentW, 40 , contentW-2, 60)];
            [cell addSubview:contentBg];
            //图标
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((contentW-20)/2, 5, 20, 20)];
            imageView.image = [UIImage imageNamed:@"DiseaseIconGrey"];
            [contentBg addSubview:imageView];
            
            //文字描述
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((contentW-15)/2, 30, 15, 30)];
            label.text = array[i];
            label.textColor = [UIColor darkGrayColor];
            label.font = [UIFont systemFontOfSize:12];
            [contentBg addSubview:label];
            label.numberOfLines = 2;
            
        }
        
        return cell;
        
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
        }
        NSDictionary *item = self.dataArray[indexPath.row];
        cell.textLabel.text = item[@"content"];
        //cell居中显示
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor clearColor];
        //点击是改变cell中文字的颜色
        cell.textLabel.highlightedTextColor = [UIColor orangeColor];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
    
}
//行的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NSDictionary *item = self.dataArray[indexPath.row];
    DXSearchDetailController *detail = [[DXSearchDetailController alloc] init];
    detail.keyWord = item[@"content"];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

//自定义的HeaderSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView  alloc] init];
    headerView.frame = CGRectMake(0, 0, SCREENH, 30);
    UILabel *line;
    if (section == 0) {
        line = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, SCREENW, 0.5)];
    }else{
        line = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, SCREENW, 0.5)];
        
    }
    
    
    line.backgroundColor = [UIColor grayColor];
    [headerView addSubview:line];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    if (section == 0) {
        
        //搜索框的设置
        UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREENW - 20, 30)];
        searchView.backgroundColor = [UIColor whiteColor];
        searchView.layer.borderWidth = 0.5;
        searchView.layer.borderColor = [[UIColor darkGrayColor]CGColor];
        searchView.layer.cornerRadius = 5;
        searchView.layer.masksToBounds = YES;
        [headerView addSubview:searchView];
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popSearchDetail:)];
        searchView.userInteractionEnabled = YES;
        [searchView addGestureRecognizer:tap];
        
        
        UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 40, 20)];
        searchLabel.text = @"搜索";
        searchLabel.textColor = [UIColor lightGrayColor];
        searchLabel.font = [UIFont systemFontOfSize:12];
        [searchView addSubview:searchLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(SCREENW - 70, 5, 1, 20)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [searchView addSubview:lineView];
        
        UIImageView *searchImagView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW-60, 0, 30, 30)];
        searchImagView.image = [UIImage imageNamed:@"SearchIcon"];
        [searchView addSubview:searchImagView];
        
        
        label.frame = CGRectMake((SCREENW - 190)*0.5, 65, 170, 20);
        label.text = @"可以搜索以下内容";
        [headerView addSubview:label];
        
    }else{
        label.frame = CGRectMake((SCREENW - 110)*0.5, 10, 90, 20);
        label.text = @"热门搜索";
        
    }
    [headerView addSubview:label];
    return headerView;
    
    
}
#pragma mark - 添加的手势响应的事件
- (void)popSearchDetail:(UITapGestureRecognizer *)tap{
    DXSearchDetailController *detail = [[DXSearchDetailController alloc] init];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    
}
//返回Header的高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 60;
    }else{
        return 40;
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100;
    }else{
        
        return 40;
    }
}
#pragma mark - 懒加载
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 64, (SCREENW-20), SCREENH-64) style:UITableViewStyleGrouped];
        _tableView.contentInset=UIEdgeInsetsMake(0, 0, 20, 0);
        _tableView.sectionFooterHeight=15;
        [self.view addSubview:_tableView];
        //取消cell的分割线
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

@end
