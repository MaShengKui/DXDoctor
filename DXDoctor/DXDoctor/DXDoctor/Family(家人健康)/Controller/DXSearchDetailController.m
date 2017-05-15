//
//  DXSearchDetailController.m
//  DXDoctor
//
//  Created by Mask on 15/10/10.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXSearchDetailController.h"
#import "AFNetworking.h"
#import "NetManager.h"
#import "DXDrugDiseaseCheckModel.h"
#import "DXHealthAnswerModel.h"
#import "DXRelateArticleModel.h"
#import "DXRelateDrugModel.h"
#import "DXRelateArticleCell.h"
#import "SVProgressHUD.h"
#import "DXMoreHealthAnswerCell.h"
#import "DXMoreHealthAnswerController.h"
#import "DXAllDetailController.h"
#import "DXQuestionAnswerController.h"
@interface DXSearchDetailController ()<UITextFieldDelegate,UIScrollViewDelegate>{

    int i;
}
@property (nonatomic, strong) UITextField *textFiled;
//判断是否跳转页面的依据
@property (nonatomic, strong) NSString *isDrug;
@property (nonatomic, strong) NSString *diseaseCheckStr;

@property (nonatomic,strong) UIView *saySorryView;

//相关疾病
@property (nonatomic, strong) NSMutableArray *relateDisease;
//相关药品
@property (nonatomic, strong) NSMutableArray *relateDrugs;
//健康问答
@property (nonatomic, strong) NSMutableArray *heathAnswer;
//相关文章
@property (nonatomic, strong) NSMutableArray *relateActicle;
//组数
@property (nonatomic, strong) NSArray *groupsArray;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DXSearchDetailController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewDidLoad];
    [self configSearch];
    [self createSaySorryView];
    self.textFiled.delegate = self;
}

#pragma mark - 创建搜索视图
-(void)configSearch{
    UIView *searchView=[[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREENW, 44)];
    searchView.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:searchView];
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10,15,34, 22);
    [backBtn setImage:[UIImage imageNamed:@"TopBack"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:backBtn];
    self.textFiled=[[UITextField alloc] initWithFrame:CGRectMake(70, 10, SCREENW-110, 30)];
    self.textFiled.placeholder=@"感冒、阿司匹林或aspl";
    self.textFiled.font = [UIFont systemFontOfSize:14];
    self.textFiled.text = self.keyWord;
    self.textFiled.textColor = [UIColor grayColor];
    self.textFiled.returnKeyType=UIReturnKeySearch;
    self.textFiled.clearButtonMode=UITextFieldViewModeWhileEditing;
    [searchView addSubview:self.textFiled];
    
    UILabel *lineLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 43,SCREENW ,1)];
    lineLable.backgroundColor=[UIColor lightGrayColor];
    [searchView addSubview:lineLable];
    
    UIImageView *searchImagView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW-40, 10, 30, 30)];
    searchImagView.image = [UIImage imageNamed:@"SearchIcon"];
    [searchView addSubview:searchImagView];
    
    //添加搜索手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(begainSearch:)];
    searchImagView.userInteractionEnabled = YES;
    [searchImagView addGestureRecognizer:tap];
    
    //判断 如果有值不弹起键盘 如果没有弹起键盘
    if ([self.textFiled.text isEqualToString:@""]) {
        [self.textFiled becomeFirstResponder];
    }else{
        //开始解析数据
        [self praserData];
    }
}

//返回
-(void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

//手势响应事件，开始搜索
- (void)begainSearch:(UITapGestureRecognizer *)tap{
    
    [self.view endEditing:YES];
    self.keyWord=self.textFiled.text;
    
    //开始解析数据
    [self praserData];
}

#pragma mark -判断是否在本页刷新
//判断是否在本页刷新（是否是药品）
- (void)praserData{
    
    [SVProgressHUD showInView:self.view status:@"加载中"];
    
    NSString *Str = [NSString stringWithFormat:@"%@",self.textFiled.text];
    
   self.diseaseCheckStr = [Str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:k_SEARCHING_URL,self.diseaseCheckStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSDictionary *dataDic = responseObject[@"data"];
        NSArray *itemArr = dataDic[@"items"];
        
        if (dataDic==nil||itemArr==nil||itemArr.count==0) {
            self.tableView.hidden=YES;
            self.saySorryView.hidden=NO;
            return ;
        }
        
        for (NSDictionary *dict in itemArr) {
           
            DXDrugDiseaseCheckModel *model = [DXDrugDiseaseCheckModel drugDiseaseWithDict:dict];

            [self createDataSoucreWithModel:model];
    
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"解析失败");
    }];
}

#pragma mark - 创建数据源
- (void)createDataSoucreWithModel:(DXDrugDiseaseCheckModel *)model{
    
    if (self.relateActicle.count != 0) {
        [self.relateActicle removeAllObjects];
    }
    
    if (self.heathAnswer.count != 0) {
        [self.heathAnswer removeAllObjects];
    }
    
    if (self.relateDisease.count!=0) {
        [self.relateDisease removeAllObjects];
    }
    
    if (self.relateDrugs.count!=0) {
        [self.relateDrugs removeAllObjects];
    }
    
    self.groupsArray=nil;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"相关科普文章");
    
    [manager GET:[NSString stringWithFormat:k_SEARCHING_RELATEARTICLE_URL,self.diseaseCheckStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSDictionary *dataDict = responseObject[@"data"];
        NSArray *itemArr = dataDict[@"items"];
        
        for (NSDictionary *dict in itemArr) {
            
            DXRelateArticleModel *model = [DXRelateArticleModel relateArticleWithDict:dict];
            [self.relateActicle addObject:model];
        }
        
        if (self.relateActicle.count == 0) {
            
            self.saySorryView.hidden=NO;
            self.tableView.hidden=YES;
            return;
        }else{
            self.saySorryView.hidden=YES;
            self.tableView.hidden=NO;
            [self.tableView reloadData];
        
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"解析失败");
    }];
    

    if ([model.is_disease isEqualToString:@"1"]) {
        
        NSDictionary *dict1 =@{@"category":@"3", @"u":@"", @"keywords":self.diseaseCheckStr, @"mc":@"fffffffff3f119d7d0a4c830210b76d7", @"page":@"1", @"hardName":@"MI+4LTE&ac=d5424fa6-adff-4b0a-8917-4264daf4a348", @"bv":@"2014", @"vc":@"4.0.7", @"vs":@"4.4.4", @"type":@"1"};
        [NetManager afPostRequestWithUrlString:k_SEARCHING_RELATEDISEASE_URL parms:dict1 finishedBlock:^(id responseObj) {
            self.relateDisease = [self secondprepareData:responseObj];
            i=i+1;
            NSLog(@"相关疾病");
            self.relateDisease =[self secondprepareData:responseObj];
            if(i==2){
              //  [self.tableView reloadData];
                
            }
        } failedBlock:^(NSString *errorMsg) {
            NSLog(@"search error:%@",errorMsg);
        }];
        
        NSLog(@"%@",[NSString stringWithFormat:k_SEARCHING_HEALTHANSWER_URL,self.diseaseCheckStr]);
        
        
        [manager GET:[NSString stringWithFormat:k_SEARCHING_HEALTHANSWER_URL,self.diseaseCheckStr] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dataDict = responseObject[@"data"];
            NSArray *itemArr = dataDict[@"items"];
             NSLog(@"相关健康问答");
            
            for (NSDictionary *dict in itemArr) {
                DXHealthAnswerModel *model = [DXHealthAnswerModel healthAnswerWithDict:dict];
                [self.heathAnswer addObject:model];
            }
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"解析失败");
        }];
    }
    
    
       if ([model.is_drug isEqualToString:@"1"]) {
        NSDictionary *dict1 =@{@"category":@"1", @"u":@"", @"keywords":self.diseaseCheckStr, @"mc":@"fffffffff3f119d7d0a4c830210b76d7", @"page":@"1", @"hardName":@"MI+4LTE&ac=d5424fa6-adff-4b0a-8917-4264daf4a348", @"bv":@"2014", @"vc":@"4.0.7", @"vs":@"4.4.4", @"type":@"1"};
        [NetManager afPostRequestWithUrlString:k_SEARCHING_RELATEDISEASE_URL parms:dict1 finishedBlock:^(id responseObj) {
            self.relateDrugs = [self secondprepareData:responseObj];
            i=i+1;
            NSLog(@"相关药品");
            if(i==2){
                
               // [self.tableView reloadData];
                
            }
        } failedBlock:^(NSString *errorMsg) {
            NSLog(@"search error:%@",errorMsg);
        }];
        
    }

}

-(NSMutableArray*)secondprepareData:(id)responseObj{
    
    NSMutableArray *dataArray=[[NSMutableArray alloc] init];
//    NSDictionary *dict=[responseObj objectForKey:@"data"];
    NSArray *array=[responseObj objectForKey:@"data"];
    for (NSDictionary *subDict in array) {
       DXRelateDrugModel *model=[[DXRelateDrugModel alloc] init];
        [model setValuesForKeysWithDictionary:subDict];
        [dataArray addObject:model];
        NSLog(@"%@", model.title);
    }
    return dataArray;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH-64) style:UITableViewStyleGrouped];
        _tableView.contentInset=UIEdgeInsetsMake(-20, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        self.automaticallyAdjustsScrollViewInsets=NO;
        _tableView.dataSource=self;
        _tableView.delegate=self;
    }
    return _tableView;
}

#pragma mark - UITableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    //此时只考虑相关药品 和相关健康问答
    if (self.heathAnswer.count>0) {
        self.groupsArray = @[self.heathAnswer, self.relateActicle];
    }
    else{
    
        self.groupsArray = @[self.relateActicle];
    }
    return self.groupsArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.groupsArray.count == 2) {
        if (section == 0) {
            return 6;
        }else{
            
            return self.relateActicle.count;
        }
    }else{
    
         return self.relateActicle.count;
    }
    
}
-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [SVProgressHUD dismiss];
   
    if (self.groupsArray.count == 2) {
        if (indexPath.section == 0) {
            
            if (indexPath.row == 5) {
                DXMoreHealthAnswerCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MoreHealthCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle]loadNibNamed:@"DXMoreHealthAnswerCell" owner:self options:nil]lastObject];
                    
                }
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
                return cell;

            
            }else{
            static NSString *identifier = @"SearchDetailCell";
            UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            DXHealthAnswerModel *model = self.heathAnswer[indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@", model.title];
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            return cell;
            }
          
        }else{

       return  [self configCellWithIndexPath:indexPath withIdentifer:@"ID" withTableview:tableView];
            
        }
    }else{
        
     return [self configCellWithIndexPath:indexPath withIdentifer:@"ID" withTableview:tableView];
   
    }
   
}
//提取方法 配置相同的cell
- (UITableViewCell *)configCellWithIndexPath:(NSIndexPath *)indexPath withIdentifer:(NSString *)identifier withTableview:(UITableView *)tableView{
    DXRelateArticleCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DXRelateArticleCell" owner:self options:nil]lastObject];
        
    }
    DXRelateArticleModel *model = self.relateActicle[indexPath.row];
    cell.model = model;
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
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
    if (self.groupsArray.count == 2) {
        if (section == 0 ) {
            title.text = @"相关健康问答";
        }else{
            
            title.text = @"相关科普文章";
        }
    }else{
        
       title.text = @"相关科普文章";
    }
    return headerView;

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGRect frame = CGRectMake(0, 0, 0, 1);
   UIView *footerView =[[UIView alloc] initWithFrame:frame];
    return footerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.groupsArray.count == 2) {
        if (indexPath.section == 0) {
            if (indexPath.row == 5) {
                return 40;
            }else{
                return 50;
            }
            
        }else{
        
            return 90;
        }
    }else{
    
        return 90;
    }
}
#pragma mark - tableView的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.groupsArray.count == 2) {
        
        if (indexPath.section == 0) {
            if (indexPath.row == 5) {
                DXMoreHealthAnswerController *more = [[DXMoreHealthAnswerController alloc] init];
                more.modelArray = self.heathAnswer;
                more.keyword = self.keyWord;
                more.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:more animated:YES];
            }else{
                DXQuestionAnswerController *answer = [[DXQuestionAnswerController alloc] init];
                answer.keyword = self.keyWord;
                DXHealthAnswerModel *model = self.heathAnswer[indexPath.row];
                answer.sort = model.sort;
                answer.articleId = model.article_id;
                answer.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:answer animated:YES];
                
            }
        }else{
            DXRelateArticleModel *model = self.relateActicle[indexPath.row];
            DXAllDetailController *detail = [[DXAllDetailController alloc] init];
            detail.ID = [model.ID stringValue];
            detail.cover_small=model.cover_small;
            detail.article=model.article_title;
            [self.navigationController pushViewController:detail animated:YES];
            
        }

    }else{
    
        DXRelateArticleModel *model = self.relateActicle[indexPath.row];
        DXAllDetailController *detail = [[DXAllDetailController alloc] init];
        detail.ID = [model.ID stringValue];
        detail.cover_small=model.cover_small;
        detail.article=model.article_title;
        [self.navigationController pushViewController:detail animated:YES];
    }
   
}
#pragma mark ===TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    NSLog(@"开始编辑");
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSLog(@"%@",string);
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{

    NSLog(@"%@", textField.text);
    NSLog(@"finishedEditing");
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"shouldBeginEditing");
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn");
    [self.view endEditing:YES];
    self.keyWord=self.textFiled.text;
    [self praserData];//搜索数据
    return YES;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [self.view endEditing:YES];
}

#pragma mark - 懒加载
  //相关疾病
- (NSMutableArray *)relateDisease{

    if (_relateDisease) {
        _relateDisease = [[NSMutableArray alloc] init];
    }
    return _relateDisease;
}
  //相关药品
- (NSMutableArray *)relateDrugs{

    if (_relateDrugs) {
        _relateDrugs = [[NSMutableArray alloc] init];
    }
    return _relateDrugs;
}
  //健康问答
- (NSMutableArray *)heathAnswer{

    if (!_heathAnswer) {
        _heathAnswer = [[NSMutableArray alloc] init];
    }
    return _heathAnswer;
}
  //相关文章
- (NSMutableArray *)relateActicle{

    if (!_relateActicle) {
        _relateActicle = [[NSMutableArray alloc] init];
    }
    return _relateActicle;
}

#pragma mark - 创建无搜索结果提示视图
-(void)createSaySorryView{
    
    self.saySorryView = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 300, SCREENH - 40)];
    [self.view addSubview:self.saySorryView];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 20)];
    label1.text = @"抱歉, 没有找到相关的结果";
    label1.font = [UIFont systemFontOfSize:16];
    label1.textColor = [UIColor grayColor];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 300, 20)];
    label2.text = @"建议您:";
    label2.font = [UIFont systemFontOfSize:16];
    label2.textColor = [UIColor grayColor];
    
    
    NSMutableString *adviceStr = [NSMutableString string];
    [adviceStr appendString:@"1.检查关键词是否有误，或换一个关键词。\n"];
    [adviceStr appendString:@"2.把一句话缩短成一个疾病、症状再重新搜索。\n"];
    [adviceStr appendString:@"3.生僻的药品可以搜索拼音的首字母，如阿司匹林，可以搜索aspl。\n"];
    [adviceStr appendString:@"4.该关键词已经匿名提交给我们， 我们会尽快完善数据，没准你下次查询的时候它就有了。\n"];
    CGRect rect = [adviceStr boundingRectWithSize:CGSizeMake(SCREENW,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,50 , SCREENW - 40, rect.size.height)];
    textLabel.font = [UIFont systemFontOfSize:12];
    textLabel.numberOfLines = 0;
    textLabel.alpha = 0.8;
    textLabel.text = adviceStr ;
    
    
    [self.saySorryView addSubview:label1];
    [self.saySorryView addSubview:label2];
    [self.saySorryView addSubview:textLabel];
    
    [self.view addSubview:self.saySorryView];
    self.saySorryView.hidden=YES;
}
@end
