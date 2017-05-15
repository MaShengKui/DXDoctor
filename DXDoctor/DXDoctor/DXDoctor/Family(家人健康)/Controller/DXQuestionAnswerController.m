//
//  DXQuestionAnswerController.m
//  DXDoctor
//
//  Created by Mask on 15/10/13.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXQuestionAnswerController.h"
#import "UMSocial.h"
@interface DXQuestionAnswerController ()
@property (nonatomic, strong) NSString *selfKeyWord;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) DXQuestionAnswerCell *selectedCell;

@property (nonatomic, strong) NSString *indexPathStr;
//黑色背景
@property (nonatomic, strong) UIView *blackView;
//半个屏幕的Tableview的背景
@property (nonatomic, strong) UIView  *whiteView;
@end

@implementation DXQuestionAnswerController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor=[UIColor whiteColor];
    [self configNavBar];
    [self praserData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view endEditing:YES];
}
#pragma mark - 配置自定义的导航栏
-(void)configNavBar{
    self.title = [NSString stringWithFormat:@"%@问答",self.keyword] ;
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
#pragma mark - 解析数据源
- (void)praserData{
    self.keyword = [self.keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:k_MOREHEALET_QUESTIONANSWER_URL, self.articleId, self.keyword] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dataDict = responseObject[@"data"];
        NSArray *itemsArray = dataDict[@"items"];
        for (NSDictionary *dict  in itemsArray) {
            DXQuestionAnswerModel *model = [DXQuestionAnswerModel questionAnswerWithDict:dict];
            [self.dataArray addObject:model];
        }
        if ( [self.sort integerValue]< self.dataArray.count) {
            [self configTableView];
            [self.tableView reloadData];
            self.view.backgroundColor = [UIColor whiteColor];
            
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:[self.sort floatValue] inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            [self.tableView selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }else{
            
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 250, 50)];
            label.text = @"没有找到相关数据!";
            [self.view addSubview:label];
        }


        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"解析失败");
    }];
  
   
}
- (void)configTableView{

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0f; // 设置为一个接近“平均”行高的值

}
#pragma mark - UITableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"questionAnswerCell";
    DXQuestionAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DXQuestionAnswerCell" owner:nil options:nil]lastObject];
    }
    DXQuestionAnswerModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.tag = 100 +indexPath.row;
    cell.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.99 alpha:1];
    //cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    cell.textLabel.preferredMaxLayoutWidth = CGRectGetWidth(tableView.bounds);
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}
#pragma  mark - 行点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //设置bgimageView的背景
    if (self.selectedCell) {
        self.selectedCell.bgView.image = [UIImage imageNamed:@"NumberBg"];
        self.selectedCell.iconView.image = [UIImage imageNamed:@"ArrowIconGray"];
    }
    DXQuestionAnswerCell *cell = (id)[self.view viewWithTag:100 + indexPath.row];
    cell.bgView.image = [UIImage imageNamed:@"NumberBgOrg"];
    cell.iconView.image = [UIImage imageNamed:@"ArrowdownnGray"];
    self.selectedCell = cell;

    
    DXQuestionAnswerModel *model = self.dataArray[indexPath.row];
    self.indexPathStr = model.content;
   // [self removeView];
    [self createSubViewWithModel:model];
    
    

}
#pragma mark - tableView的高度的设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (self.selectedCell) {
//        DXQuestionAnswerModel *model = self.dataArray[indexPath.row];
//        NSString *string = model.content;
//        CGRect rect = [string boundingRectWithSize:CGSizeMake(300,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
//        return rect.size.height + 60;
//    }else{
    
        return 60;
   // }
   
}

#pragma mark - 移除生成的子View
- (void)removeView{
    [self.whiteView removeFromSuperview];
    [self.blackView removeFromSuperview];
    
   }
#pragma mark -创建子tableview的数据
- (void)createSubViewWithModel:(DXQuestionAnswerModel *)model {
    
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
    
    
    //自定义whiteView的高
    self.whiteView = [[UIView alloc] init];
    self.whiteView.backgroundColor = [UIColor whiteColor];
   
//
    NSString *string = model.content;
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREENW-40,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, SCREENW-60, rect.size.height+10)];

    textView.font = [UIFont systemFontOfSize:16];
    textView.text = string ;
    textView.editable=NO;
    textView.selectable=NO;
   
    [self.whiteView addSubview:textView];
    
    if (rect.size.height>SCREENH-60) {
        textView.frame=CGRectMake(10, 10, SCREENW-60, 300);
        self.whiteView.frame = CGRectMake(20, (SCREENH-310)*0.5, SCREENW-40, 300+10);
    }else{
    
     self.whiteView.frame = CGRectMake(20, (SCREENH-rect.size.height+30)*0.5, SCREENW-40, rect.size.height+30);
    }
    self.whiteView.layer.cornerRadius=5;
    [self.view addSubview:self.whiteView];

    
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
        _tableView.bounces = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-  (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
@end
