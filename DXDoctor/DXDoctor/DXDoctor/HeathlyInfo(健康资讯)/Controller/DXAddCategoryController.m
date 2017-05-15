//
//  DXAddCategoryController.m
//  DXDoctor
//
//  Created by Mask on 15/9/25.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXAddCategoryController.h"

@interface DXAddCategoryController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayGroup1;
@property (nonatomic, strong) NSMutableArray *arrayGroup2;

@property (nonatomic, strong) NSArray *tempArray;
@end

@implementation DXAddCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createDataSource];
    [self creatNavigationItem];

}
#pragma mark -创建数据源
/**
 创建数据源
 */
- (void)createDataSource{
    self.navigationItem.title = @"频道管理";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.arrayGroup1 = [[NSMutableArray alloc] init];
    self.arrayGroup2 = [[NSMutableArray alloc] initWithObjects:@"肿瘤",@"母婴", @"营养", @"慢病", nil];
   
    for (NSString *str1  in self.cagoryArray) {
       
        for (NSString *str2 in self.arrayGroup2) {
            if ([str1 isEqualToString:str2]) {
                [self.arrayGroup1 addObject:str2];
            }
        }
    }
    
    for (NSString *str in self.arrayGroup1) {
        [self.arrayGroup2 removeObject:str];
    }
}
- (void)creatNavigationItem{
    
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightbtn.frame = CGRectMake(0, 0, 50, 30);
    [rightbtn setTitle:@"完成" forState:UIControlStateNormal];
    rightbtn.titleLabel.font=[UIFont systemFontOfSize:15];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = right;
    
    [rightbtn addTarget:self action:@selector(callBack) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)callBack{

    if (self.arrayGroup1.count <3) {
        self.addCategoryBlock(self.arrayGroup1);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    
        UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择其中两个添加频道" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}

#pragma mark -tableView的代理方法
//返回组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
//返回每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return self.arrayGroup1.count;
    }else{
    
        return self.arrayGroup2.count;
    }
}
//cell 的复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifer = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = self.arrayGroup1[indexPath.row];
    }else{
    
        cell.textLabel.text = self.arrayGroup2[indexPath.row];
    }
    
    return cell;
}
//返回每组的header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
//返回每组的header的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return @"已选频道";
    }else{
    
        return @"未选频道";
    }
}

//返回编辑的模式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return UITableViewCellEditingStyleDelete;
    }else{
    
        return UITableViewCellEditingStyleInsert;
    }
}
//行的编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete ) {
         id object = self.arrayGroup1[indexPath.row];
        [self.arrayGroup1 removeObjectAtIndex:indexPath.row];
        [self.arrayGroup2 insertObject:object atIndex:self.arrayGroup2.count];
        [tableView reloadData];
    }else if (editingStyle == UITableViewCellEditingStyleInsert){
         id object = self.arrayGroup2[indexPath.row];
        [self.arrayGroup2 removeObjectAtIndex:indexPath.row];
        [self.arrayGroup1 insertObject:object atIndex:self.arrayGroup1.count];
        [tableView reloadData];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
//行的移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//行移动操作
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{

    // 1.先确定起始行和目标行
    NSInteger fromRow = sourceIndexPath.row;
    NSInteger destRow = destinationIndexPath.row;
    if (sourceIndexPath.section == 0) {
        //2.把起始行的位置的对应的数组的元素 找出来
        id object = self.arrayGroup1[fromRow];
        
        //3.把取出来的元素 从起始行位置删除
        [self.arrayGroup1 removeObject:object];
        
        //4.把找出来的元素插入到目标位置
        [self.arrayGroup1 insertObject:object atIndex:destRow];
    }else{
        id object = self.arrayGroup2[fromRow];
        [self.arrayGroup2 removeObject:object];
        [self.arrayGroup2 insertObject:object atIndex:destRow];
    }
    //5.改变UI效果 重新加载一下数据， 让tableView重新加载交换顺序后的数据
    [tableView reloadData];
}
#pragma mark - 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH - 64 -49) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:239/255.0 blue:238/255.0 alpha:1];
        _tableView.editing = YES;
        [self.view addSubview:_tableView];
    }
    return _tableView;
    
}

@end
