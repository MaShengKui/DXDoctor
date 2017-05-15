//
//  DXCollectionController.m
//  DXDoctor
//
//  Created by Mask on 15/9/27.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXCollectionController.h"
#import "DBManager.h"
#import "DXFavoriteModel.h"
#import "DXAllDetailController.h"
@interface DXCollectionController (){
    
    NSMutableArray *_dataArray;
}


@end

@implementation DXCollectionController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self creatDataSource];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    self.view.backgroundColor=[UIColor colorWithRed:245/255.0f green:246/255.0f blue:247/255.0f alpha:1];
    self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
}

- (void)creatDataSource{
    
    //后面执行一个方法 执行一个返回值为可变数据的方法
    _dataArray = [[DBManager shareManager]selectFromTable];
    NSLog(@"共有%d个收藏文章", _dataArray.count);
    
    if (_dataArray.count==0) {
        UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH-64)];
        bgView.backgroundColor=[UIColor colorWithRed:245/255.0f green:246/255.0f blue:247/255.0f alpha:1];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake((SCREENW-55)*0.5, 150, 55, 55)];
        imgView.image=[UIImage imageNamed:@"icon-wuneirong@3x"];
        [bgView addSubview:imgView];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake((SCREENW-50)*0.49, 215, 50, 20)];
        label.text=@"暂无收藏";
        label.font=[UIFont systemFontOfSize:12];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1];
        [bgView addSubview:label];
        [self.view addSubview:bgView];
        return;
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" ];
    
    if (!cell) {
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID" ];
    }
    DXFavoriteModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.other;
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:13];
    cell.textLabel.numberOfLines=0;
    cell.detailTextLabel.textColor=[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
    
    UIImage *image = [UIImage imageWithData:model.coverData];
    CGSize itemSize = CGSizeMake(80, 60);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0);
    CGRect rect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [image drawInRect:rect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.imageView.layer.cornerRadius = 3;
    cell.imageView.layer.masksToBounds = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DXFavoriteModel *model = _dataArray[indexPath.row];
        [[DBManager shareManager]deleteArticleWithArticleId:model.articleId];
        [_dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DXFavoriteModel *model = _dataArray[indexPath.row];
    DXAllDetailController *detial = [[DXAllDetailController alloc] init];
    detial.ID = model.articleId;
    detial.article=model.title;
    if (model.coverData!=nil) {
        detial.coverData=model.coverData;
    }
    [self.navigationController pushViewController:detial animated:YES];
    
}

-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
@end
