//
//  DXMoreHealthAnswerController.m
//  DXDoctor
//
//  Created by Mask on 15/10/12.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXMoreHealthAnswerController.h"
#import "DXHealthAnswerModel.h"
@interface DXMoreHealthAnswerController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITextField *textFiled;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DXMoreHealthAnswerController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
   // self.groupArray = [[NSMutableArray alloc] init];
    [self configSearch];
    [self configTableView];
}

-(void)configSearch{
    UIView *searchView=[[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREENW, 44)];
    searchView.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:searchView];
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10,15,34, 22);
    [backBtn setImage:[UIImage imageNamed:@"TopBack"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:backBtn];
    self.textFiled=[[UITextField alloc] initWithFrame:CGRectMake(70, 10, SCREENW, 30)];
    self.textFiled.enabled=NO;
//    [self.textFiled becomeFirstResponder];
    self.textFiled.placeholder=self.keyword;
    self.textFiled.font = [UIFont systemFontOfSize:14];
    self.textFiled.textColor = [UIColor grayColor];
    [searchView addSubview:self.textFiled];
    
    UILabel *lineLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 43,SCREENW ,1)];
    lineLable.backgroundColor=[UIColor lightGrayColor];
    [searchView addSubview:lineLable];
    
    UIImageView *searchImagView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW-60, 10, 30, 30)];
    searchImagView.image = [UIImage imageNamed:@"SearchIcon"];
    [searchView addSubview:searchImagView];
    
}
//返回
-(void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)configTableView{
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
}
#pragma mark - UITableViewDelegat
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
        DXHealthAnswerModel *model = self.modelArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"DiseaseIconGreen"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = model.title;
  
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DXQuestionAnswerController *answer = [[DXQuestionAnswerController alloc] init];
    answer.keyword = self.textFiled.placeholder;
    DXHealthAnswerModel *model = self.modelArray[indexPath.row];
    answer.sort = model.sort;
    answer.articleId = model.article_id;
    answer.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:answer animated:YES];
  

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else{
    
        return 15;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, 30)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, SCREENW-40, 15)];
    title.font = [UIFont boldSystemFontOfSize:14];
    title.textColor = [UIColor grayColor];
    [headerView addSubview:title];

        if (section == 0 ) {
            title.text = @"相关健康问答";
        }
    headerView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    return headerView;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGRect frame = CGRectMake(0, 0, 0, 1);
    UIView *footerView =[[UIView alloc] initWithFrame:frame];
    return footerView;
    
}
#pragma mark - 懒加载
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

@end
