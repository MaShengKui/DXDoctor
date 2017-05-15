//
//  DXHealthTestController.m
//  DXDoctor
//
//  Created by Mask on 15/10/14.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXHealthTestController.h"

@interface DXHealthTestController (){

    UIView *bgView;
}
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DXHealthTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self praserData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//解析数据
- (void)praserData{
    self.navigationItem.title = @"健康测评";
    self.tableView.bounces = NO;
    self.dataArray = [[NSMutableArray alloc] init];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:k_HEALTHTEST_URL]];
    if (data==nil) {
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH-64)];
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
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *dataArray = rootDic[@"data"];
    for (NSDictionary *itemDict in dataArray) {
        DXHealthTestModel *model = [DXHealthTestModel healthTestWithDict:itemDict];
        [self.dataArray  addObject:model];
    }
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSLog(@"%d", self.dataArray.count);
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"HealthTest";
    DXHealthTestCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DXHealthTestCell" owner:self options:nil]lastObject];
    }
    DXHealthTestModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}
#pragma mark - 行点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DXTestQuestionController *quest = [[DXTestQuestionController alloc] init];
    DXHealthTestModel *model = self.dataArray[indexPath.row];
    quest.model = model;
    quest.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:quest animated:YES];
    
    
}


@end
