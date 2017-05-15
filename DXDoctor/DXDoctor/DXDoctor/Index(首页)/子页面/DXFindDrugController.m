//
//  DXFindDrugController.m
//  DXDoctor
//
//  Created by Mask on 15/10/5.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXFindDrugController.h"
#import "AFNetworking.h"
#import "DXSearchDetailController.h"
@interface DXFindDrugController (){

    UIView *bgView;
}

@property (nonatomic, strong) NSString *indexPathStr;

@property (nonatomic, strong)DXFindDrugCell *selectedCell;
//黑色背景
@property (nonatomic, strong) UIView *blackView;
//半个屏幕的Tableview的背景
@property (nonatomic, strong) UIView  *whiteView;
//生成的子TableView
@property (nonatomic, strong) UITableView *subTableView;
//子Tableview的数据源
@property (nonatomic, copy) NSArray *subDataArray;

@end

@implementation DXFindDrugController
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    if (self.blackView) {
        [self.blackView removeFromSuperview];
    }
    if (self.whiteView) {
        [self.whiteView removeFromSuperview];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self configNavBar];
    [self createDataSource];
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    NSInteger selectIndex=0;
    NSIndexPath *selectIndexPath=[NSIndexPath indexPathForRow:selectIndex inSection:0];
    if (self.dataArray.count>0) {
        [self.tableView selectRowAtIndexPath:selectIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    }
}
-(void)configNavBar{
    self.title = @"常见病症";
    self.navigationController.navigationBarHidden = NO;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 66, 22);
    [btn setImage:[UIImage imageNamed:@"TopBackWhite"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=item;
    
//    UIButton *rightBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn1.frame=CGRectMake(0, 0, 30, 30);
//    [rightBtn1 setImage:[UIImage imageNamed:@"PromptSearch"] forState:UIControlStateNormal];
//    [rightBtn1 addTarget:self action:@selector(searchDrugs) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item1=[[UIBarButtonItem alloc] initWithCustomView:rightBtn1];
//    self.navigationItem.rightBarButtonItem = item1;
    
    
}
//返回按钮
-(void)btnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
//找药
- (void)searchDrugs{
    
}
#pragma mark - 创建数据源
- (void)createDataSource{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:k_FINDDRUGS_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    NSURL *url = [NSURL URLWithString:k_FINDDRUGS_URL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data==nil) {
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
    [bgView removeFromSuperview];
    NSDictionary *RootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *dataArray = RootDict[@"data"];
    for (NSDictionary *items in dataArray) {
        DXFindDrugModel *model = [DXFindDrugModel findDrugWithDict:items];
        [self.dataArray  addObject:model];
    }
    NSLog(@"%d", self.dataArray.count);
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return self.dataArray.count;
    }else{
    
        return self.subDataArray.count;
    }

    
}
//cell的复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"findDrugCell";
    if (tableView == self.tableView) {
        DXFindDrugCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DXFindDrugCell" owner:self options:nil]lastObject];
        }
        DXFindDrugModel *model = self.dataArray[indexPath.row];
        cell.model = model;
        cell.tag = 100 +indexPath.row;
        cell.position.text = [NSString stringWithFormat:@"%d",indexPath.row +1];
        cell.bgImageView.image = [UIImage imageNamed:@"NumberBg"];
        return cell;
    }else{
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = self.subDataArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        return cell;

    }

   
}
//header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (tableView == self.subTableView) {
        UIView *headerCellView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, SCREENW, 40)];
        headerCellView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
        titleLabel.text = self.indexPathStr;
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        titleLabel.textColor = [UIColor orangeColor];
        [headerCellView addSubview:titleLabel];
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40-1, SCREENW, 1)];
        lineLabel.backgroundColor = [UIColor darkGrayColor];
        [headerCellView addSubview:lineLabel];
        return headerCellView;
    }else{
    
        return nil;
    }
}
//header 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (tableView ==  self.subTableView) {
        return 40;
    }
    else{
    
        return 0;
    }
}
//cell 的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == self.tableView) {
        return 60;
    }else{
    
        return 45;
    }
    
}
#pragma mark - 行的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.tableView) {
        //设置bgimageView的背景
        if (self.selectedCell) {
            self.selectedCell.bgImageView.image = [UIImage imageNamed:@"NumberBg"];
        }
        DXFindDrugCell *cell = (id)[self.view viewWithTag:100 + indexPath.row];
        cell.bgImageView.image = [UIImage imageNamed:@"NumberBgOrg"];
        self.selectedCell = cell;
        
        
        DXFindDrugModel *model = self.dataArray[indexPath.row];
        self.indexPathStr = model.name;
        [self removeView];
        [self createSubViewWithModel:model];
    }else{
        DXSearchDetailController *detail = [[DXSearchDetailController alloc] init];
        NSString *keyword = self.subDataArray[indexPath.row];
        detail.keyWord = keyword;
        [self.navigationController pushViewController: detail animated:YES];
    }
   
    
}
#pragma mark - 移除生成的子View
- (void)removeView{

    self.blackView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha = 0.0;
    [UIView animateWithDuration:0.5 animations:^{
        self.blackView.alpha = 0.4;
    }];
    [self.view addSubview: self.blackView];
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RemoveTableView:)];
    [ self.blackView addGestureRecognizer:tap];
    
    self.whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENH/2, SCREENW, SCREENH/2)];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.whiteView];
    
    _subTableView = [[UITableView alloc] initWithFrame:CGRectMake(60, 0, SCREENW-75, SCREENH/2) style:UITableViewStylePlain];
    _subTableView.bounces = NO;
    _subTableView.separatorStyle = NO;
    self.subTableView.showsVerticalScrollIndicator = NO;
    [self.whiteView addSubview:self.subTableView];
}
#pragma mark -创建子tableview的数据
- (void)createSubViewWithModel:(DXFindDrugModel *)model {
    self.subDataArray = nil;
    //解析数据
    NSString *keyWord =  model.keywords;
    //分割字符串
    self.subDataArray = [keyWord componentsSeparatedByString:@";"];
    NSLog(@"%d", self.subDataArray.count);
    self.subTableView.delegate = self;
    self.subTableView.dataSource= self;
    
}
//手势响应的事件
- (void)RemoveTableView:(UITapGestureRecognizer *)tap{
    //移除生成的tablevie
    [self.blackView removeFromSuperview];
    [UIView animateWithDuration:1.0 animations:^{
    [self.whiteView removeFromSuperview];
    }];
    
    
}
#pragma mark - 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSArray *)subDataArray{

    if (!_subDataArray) {
        _subDataArray = [[NSMutableArray alloc] init];
    }
    return _subDataArray;
}

@end
