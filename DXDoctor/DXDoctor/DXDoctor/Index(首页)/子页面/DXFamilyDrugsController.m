//
//  DXFamilyDrugsController.m
//  DXDoctor
//
//  Created by Mask on 15/10/9.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXFamilyDrugsController.h"
#import "DXFamilyDrugsModel.h"
#import "UMSocial.h"
#import "DBManager.h"
#import "SVProgressHUD.h"
#import "DXFamilyDrugsDetailedViewController.h"
@interface DXFamilyDrugsController ()<UIAlertViewDelegate>{

    DXFamilyDrugsModel *modelTmp;
    NSIndexPath *indexPathTmp;
    UIAlertView *addAlertView;
    UIAlertView *changeAlertView;
}

@end

@implementation DXFamilyDrugsController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.dataArray=[[DBManager shareManager]selectFromDrugTable];
    self.dataArray=[self compareArrayElementDrugID:self.dataArray];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavBar];
    [self configTableView];
}
-(void)configNavBar{
    self.title = @"我的药箱";
    self.navigationController.navigationBarHidden = NO;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 66, 22);
    [btn setImage:[UIImage imageNamed:@"TopBackWhite"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=item;
    
    UIButton *rightBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame=CGRectMake(0, 0, 26, 26);
    [rightBtn1 setImage:[UIImage imageNamed:@"ShareIcon"] forState:UIControlStateNormal];
    [rightBtn1 setImage:[UIImage imageNamed:@"ShareIconSel"] forState:UIControlStateSelected];
    [rightBtn1 addTarget:self action:@selector(rightBtn1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc] initWithCustomView:rightBtn1];
    self.navigationItem.rightBarButtonItem = item1;
    
    
}
//返回按钮
-(void)btnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
//分享按钮
-(void)rightBtn1Clicked:(UIButton*)btn{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:nil shareText:k_SHARE_RUL shareImage:nil shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,UMShareToRenren,UMShareToDouban,UMShareToTencent,UMShareToQzone] delegate:nil];
}
- (void)configTableView{
    
//    for (NSDictionary *itemsDict in self.DrugsArray) {
//        DXFamilyDrugsModel *model = [DXFamilyDrugsModel familyDrugsWithDict:itemsDict];
//        [self.dataArray addObject:model];
//    }
    [self.tableView reloadData];
}
#pragma mark - UITableViewDelegate
//返回组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.dataArray.count;
    }
    
}
//cell的复用
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"familyDrugsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    if (indexPath.section == 1) {
        DXFamilyDrugsModel *model = self.dataArray[indexPath.row];
        cell.textLabel.text = model.showName;
        cell.detailTextLabel.text=model.remark;
        cell.detailTextLabel.textColor = [UIColor grayColor];
//        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
////        [moreBtn setImage:[UIImage imageNamed:@"Icon04"] forState:UIControlStateNormal];
//        [moreBtn setTitle:@"修改" forState:UIControlStateNormal];
//        [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        moreBtn.frame = CGRectMake(SCREENW-45, 0, 45, cell.frame.size.height);
//        moreBtn.titleLabel.font=[UIFont systemFontOfSize:13];
//        [moreBtn addTarget:self action:@selector(editDrugsInfoClickAction: event:) forControlEvents:UIControlEventTouchUpInside];
//        cell.accessoryView = moreBtn;
        if ([model.remark isEqualToString:@""]) {
            cell.imageView.image = [UIImage imageNamed:@"NoteIconGray"];
            cell.detailTextLabel.text = @"点击药品可添加备注";
        }else{
        cell.imageView.image = [UIImage imageNamed:@"NoteIconGreen"];
        cell.detailTextLabel.text = model.remark;
        }
    }else{
    
        cell.textLabel.text = @"添加药物";
        cell.imageView.image = [UIImage imageNamed:@"MedNumAdd"];
        cell.detailTextLabel.text = @"";
        cell.accessoryView = nil;
    }
    return cell;
}
- (void)editDrugsInfoClickAction:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil)
    {
        [self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath : indexPath];
    }
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //code
    modelTmp = self.dataArray[indexPath.row];
    indexPathTmp=indexPath;
    
    if (changeAlertView==nil) {
        changeAlertView = [[UIAlertView alloc] initWithTitle:@"修改药品信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        changeAlertView.tag=2000;
    }
    [changeAlertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    
    UITextField *nameField = [changeAlertView textFieldAtIndex:0];
    nameField.frame=CGRectMake(nameField.frame.origin.x, nameField.frame.origin.y, nameField.frame.size.width, nameField.frame.size.height+20);
    nameField.placeholder = @"请输入药品名称";
    nameField.text=modelTmp.showName;
    
    UITextField *remarkField = [changeAlertView textFieldAtIndex:1];
    remarkField.frame=CGRectMake(remarkField.frame.origin.x, remarkField.frame.origin.y, remarkField.frame.size.width, remarkField.frame.size.height+20);
    [remarkField setSecureTextEntry:NO];
    remarkField.placeholder = @"请输入药品备注";
    remarkField.text=modelTmp.remark;
    
    [changeAlertView show];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        if (addAlertView==nil) {
            addAlertView = [[UIAlertView alloc] initWithTitle:@"添加药品名称和备注" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            addAlertView.tag=1000;
        }
        [addAlertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        
        UITextField *nameField = [addAlertView textFieldAtIndex:0];
        nameField.frame=CGRectMake(nameField.frame.origin.x, nameField.frame.origin.y, nameField.frame.size.width, nameField.frame.size.height+20);
        nameField.placeholder = @"请输入药品名称";
        
        UITextField *remarkField = [addAlertView textFieldAtIndex:1];
        remarkField.frame=CGRectMake(remarkField.frame.origin.x, remarkField.frame.origin.y, remarkField.frame.size.width, remarkField.frame.size.height+20);
        [remarkField setSecureTextEntry:NO];
        remarkField.placeholder = @"请输入药品备注";
        
        [addAlertView show];

        
    }else if (indexPath.section==1){
    
//        modelTmp = self.dataArray[indexPath.row];
//        indexPathTmp=indexPath;
//        
//        if (changeAlertView==nil) {
//            changeAlertView = [[UIAlertView alloc] initWithTitle:@"修改药品信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            changeAlertView.tag=2000;
//        }
//        [changeAlertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
//        
//        UITextField *nameField = [changeAlertView textFieldAtIndex:0];
//        nameField.frame=CGRectMake(nameField.frame.origin.x, nameField.frame.origin.y, nameField.frame.size.width, nameField.frame.size.height+20);
//        nameField.placeholder = @"请输入药品名称";
//        nameField.text=modelTmp.showName;
//        
//        UITextField *remarkField = [changeAlertView textFieldAtIndex:1];
//        remarkField.frame=CGRectMake(remarkField.frame.origin.x, remarkField.frame.origin.y, remarkField.frame.size.width, remarkField.frame.size.height+20);
//        [remarkField setSecureTextEntry:NO];
//        remarkField.placeholder = @"请输入药品备注";
//        remarkField.text=modelTmp.remark;
//        
//        [changeAlertView show];
        DXFamilyDrugsModel *model = self.dataArray[indexPath.row];
        DXFamilyDrugsDetailedViewController *drugsDetailedVC=[[DXFamilyDrugsDetailedViewController alloc]init];
        drugsDetailedVC.hidesBottomBarWhenPushed=YES;
        drugsDetailedVC.model=model;
        [self.navigationController pushViewController:drugsDetailedVC animated:YES];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1000) {
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            UITextField *nameField = [alertView textFieldAtIndex:0];
            UITextField *remarkField = [alertView textFieldAtIndex:1];
            
            if ([nameField.text length]==0) {
                [SVProgressHUD showInView:self.view];
                [SVProgressHUD dismissWithError:@"药品名称不能为空"];
                return;
            }
            //毫秒级的时间戳
            NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
            [formatter setDateFormat:@"YYYYMMddhhmmssSSS"];
            NSString *date =  [formatter stringFromDate:[NSDate date]];
            NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
            
            //随机数
            int num = arc4random() % 10000;
            
            //将两者结合，暂时生成一个本地唯一的id值
            NSString *drugId=[NSString stringWithFormat:@"%@ %d",timeLocal,num];
            
            if ([[DBManager shareManager]insertDrugWithDrugId:drugId showName:nameField.text remark:remarkField.text]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD showInView:self.view];
                    [SVProgressHUD dismissWithSuccess:@"添加药品成功!"];
                });
            }else{
            
                [SVProgressHUD showInView:self.view];
                [SVProgressHUD dismissWithSuccess:@"添加失败!"];
                return;
            }
            
            self.dataArray=[[DBManager shareManager] selectFromDrugTable];
            self.dataArray=[self compareArrayElementDrugID:self.dataArray];
            [self.tableView reloadData];
            
            [self.view endEditing:YES];
        }
    }else if (alertView.tag==2000) {
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            UITextField *nameField = [alertView textFieldAtIndex:0];
            UITextField *remarkField = [alertView textFieldAtIndex:1];
            if ([nameField.text length]==0) {
                [SVProgressHUD showInView:self.view];
                [SVProgressHUD dismissWithError:@"药品名称不能为空"];
                return;
            }
            modelTmp.showName=nameField.text;
            modelTmp.remark=remarkField.text;
            
            if ([[DBManager shareManager]updateDrugInfoWithDrugId:modelTmp.drugId showName:nameField.text remark:remarkField.text]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD showInView:self.view];
                    [SVProgressHUD dismissWithSuccess:@"修改成功!"];
                });
            }else{
                [SVProgressHUD showInView:self.view];
                [SVProgressHUD dismissWithSuccess:@"修改失败!"];
                return;
            }
            [self.dataArray replaceObjectAtIndex:indexPathTmp.row withObject:modelTmp];
            [self.tableView reloadData];
            [self.view endEditing:YES];
        }
    }
}

#pragma mark - 删除操作
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        return YES;
    }else{
    
        return NO;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{

    return @"删除";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DXFamilyDrugsModel *model=[self.dataArray objectAtIndex:indexPath.row];
        [self.dataArray removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        
        [tableView beginUpdates];
        
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

        [[DBManager shareManager]deleteDrugWithDrugId:model.drugId];
        
        [tableView endUpdates];
        [self.tableView reloadData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

#pragma mark - header的设置
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return @"自定义药品";
    }else{
    
        NSString *str = [NSString stringWithFormat:@"我的药箱-常备药(%d种)", self.dataArray.count];
        return str;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 35;
}

#pragma  mark - 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.sectionFooterHeight=0;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - 服务时间排序，按距离今天的时间长短进行排序，最近的排在最前
-(NSMutableArray *)compareArrayElementDrugID:(NSMutableArray *)serviceArray{
    
    NSArray *resultArray;
    resultArray = [serviceArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        DXFamilyDrugsModel *model1 = obj1;
        DXFamilyDrugsModel *model2 = obj2;
        if ([model1.drugId doubleValue] > [model2.drugId doubleValue]) {
            return NSOrderedAscending;//降序
        }else if ([model1.drugId doubleValue] <[model2.drugId doubleValue])
        {
            return NSOrderedDescending;//升序
        }else
        {
            return NSOrderedSame;//相等
        }
    }];
   
    NSMutableArray *arrayTmp=[[NSMutableArray alloc] initWithArray:resultArray];
    return arrayTmp;
}

- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
