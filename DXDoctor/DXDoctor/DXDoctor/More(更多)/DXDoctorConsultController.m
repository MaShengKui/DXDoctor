//
//  DXDoctorConsultController.m
//  DXDoctor
//
//  Created by Mask on 15/10/15.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXDoctorConsultController.h"
#import "DXChatCell.h"
#import "DXChatModel.h"

@interface DXDoctorConsultController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_myTableView;
    //放chatModel实例
    NSMutableArray *_dataArray;
    //底部的聊天视图
    UIView *_chatView;
    UITextField *_chatField;
    //模拟刷新效果
    UIImageView *_refreshView;
    NSInteger index;
    
}
@end

@implementation DXDoctorConsultController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TopBarHD.png"] forBarMetrics:UIBarMetricsDefault ];
    [self configNavBar];
    _dataArray = [[NSMutableArray alloc] init];
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64,[DeviceManager currentScreenSize].width,[DeviceManager currentScreenSize].height) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource= self;
    _myTableView.showsHorizontalScrollIndicator=NO;
    _myTableView.showsVerticalScrollIndicator=NO;
    _myTableView.contentInset=UIEdgeInsetsMake(0, 0, 50, 0);
    //设置cell之间无分割线的模式
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    [self createChatView];
    
    //通知中心(单例，每个应用程序只有一个通知中心实例)，监听UITextField 键盘的出现和消失
    //设计模式（观察者模式）:通知中心符合这一模式
    //在通知中心将self注册成为观察者,  name 广播的名称,self能够通过通知中心接收到名为UIKeyboardWillShowNotification的广播,接收到广播后，能够触发@selector的方法
    //UITextField 会在键盘即将出现的时候通过[[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillShowNotification object:nil];自动发送一条名为UIKeyboardWillShowNotification的广播
    //消息中心（多（一条广播能被多个对象发送）对多（一条广播也能被多个对象接收））
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(writeTextEndEditingFuncAction:)];
    [_myTableView addGestureRecognizer:tap];
    
    index=0;
}
//结束编辑
-(void)writeTextEndEditingFuncAction:(UIGestureRecognizer *)tap{
    
    [self.view endEditing:YES];
}

-(void)configNavBar{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 66, 22);
    [btn setImage:[UIImage imageNamed:@"TopBackWhite.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=item;
    
   self.navigationItem.title = @"用药咨询";
    
    
}
-(void)btnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 键盘处理部分-键盘消失
- (void)keyBoardWillHidden:(NSNotification *)not{
    [UIView animateWithDuration:0.1 animations:^{
        _myTableView.frame = CGRectMake(0,0,[DeviceManager currentScreenSize].width ,[DeviceManager currentScreenSize].height);
        _chatView.frame = CGRectMake(0,[DeviceManager currentScreenSize].height-40,[DeviceManager currentScreenSize].width,40);
    }];
}

#pragma mark - 键盘处理部分-键盘弹起
//NSNotification (通知中心中，传递参数的载体)
- (void)keyBoardWillShow:(NSNotification *)not{
    //调整视图的frame
    //获取键盘的高度
    CGSize size = [[not.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//    CGPoint point=[[not.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin;
    //为代码的执行加上动画缓冲效果,Duration动画时长
    [UIView animateWithDuration:0.1
                     animations:^{
                         //数值变化的代码
//                         _myTableView.frame = CGRectMake(0,0,[DeviceManager currentScreenSize].width,[DeviceManager currentScreenSize].height-size.height);
                         //数值变化的代码
                         CGRect viewFrame = [_myTableView frame];
                         
                         viewFrame.size.height -= size.height-20;
                         
                         _myTableView.frame = viewFrame;
                         
                         CGRect frameTmp=CGRectMake(0, [self caculateAllCellHeight]+20, SCREENW, [self caculateAllCellHeight]);
                         
                         [_myTableView scrollRectToVisible:frameTmp animated:YES];
                         
                         _chatView.frame = CGRectMake(0,[DeviceManager currentScreenSize].height-40-size.height,[DeviceManager currentScreenSize].width,40);
                     }];
}

#pragma mark - 计算所有cell的行高
-(CGFloat)caculateAllCellHeight{

    CGFloat height=0;
    for (DXChatModel *model in _dataArray) {
        NSString *chatText = model.chatText;
        height+=[self caculatorHeightOfString:chatText].size.height+40;
    }
    return height;
}
- (void)createChatView{
    _chatView = [[UIView alloc] initWithFrame:CGRectMake(0,SCREENH - 40,SCREENW,40)];
    _chatView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_chatView];
    
    _chatField = [[UITextField alloc] initWithFrame:CGRectMake(10,5,SCREENW-80,30)];
    _chatField.delegate = self;
    _chatField.borderStyle = UITextBorderStyleRoundedRect;
    [_chatField resignFirstResponder];
    [_chatView addSubview:_chatField];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setFrame:CGRectMake(SCREENW-60,5,50,30)];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    sendBtn.layer.borderWidth=1;
    sendBtn.layer.cornerRadius=5;
    sendBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    [_chatView addSubview:sendBtn];
    
    //模拟刷新的imageView
    _refreshView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,30,30)];
    _refreshView.image = [UIImage imageNamed:@"BookBg"];
    [self.view addSubview:_refreshView];
    _refreshView.hidden = YES;
}

#pragma mark - 发送消息
- (void)sendMessage{
    [self.view endEditing:YES];
    if ([_chatField.text length] == 0) {
        //添加“消息内容不能为空”说明
        return;
    }
    if (index>=8) {
        index=0;
    }
    DXChatModel *model = [[DXChatModel alloc] init];
    model.chatText=_chatField.text;
    model.isSelf = YES;
    [_dataArray addObject:model];
    [_myTableView reloadData];
    _chatField.text = @"";
    _chatField.keyboardType = UIKeyboardTypeNamePhonePad;
    //取到tableView，最后一行的indexPath
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataArray.count -1 inSection:0];
    //让tableView的内容视图，自动滚动到指定的indexPath
    //UITableViewScrollPositionBottom(底部向上滚动)
    [_myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    //展现刷新的图片
    _refreshView.hidden = NO;
    //起个定时器，让图片转起来
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateImageView:) userInfo:nil repeats:YES];
    //一段时间后，执行自动回复方法 self 2秒后，调用 autoSpeak方法
    [self performSelector:@selector(autoSpeak) withObject:nil afterDelay:2.0];
}


#pragma mark - 自动回复
- (void)autoSpeak{
    _refreshView.hidden = YES;
    
    NSString *str1=@"嗨，您好，我是丁香机器人，很高兴为您服务！😀";
    NSString *str2=@"想跟我聊天？我会的不多，请多多关照！";
    NSString *str3=@"不好意思,请您准确说出您的需要，谢谢！";
    NSString *str4=@"不好意思,系统无法识别您的需要，谢谢！";
    NSString *str5=@"您说的我好像都听不懂啊，说清楚一点好吗？亲~ 😂";
    NSString *str6=@"最近比较烦，比较烦，比较烦，老板的任务总是天天做不完，你要问我何时会在线，我说基本上这个很难！ 😭";
    NSString *str7=@"ｍｍ请再发一次，我就与你联系；ｊｊ请再发两次，我就与你联系；ｇｇ、ｄｄ就不要再发了，因为发了也不再和你联系！ 💔";
    NSString *str8=@"哼，不理你了，我走啦！ 💔";
    
    //自动回复的数据
    NSArray *array = [NSArray arrayWithObjects:str1,str2,str3,str4,str5,str6,str7,str8,nil];
    
    if (index>=0&&index<=array.count-1) {
        DXChatModel *model = [[DXChatModel alloc] init];
        model.chatText = [array objectAtIndex:index];
        model.isSelf = NO;
        [_dataArray addObject:model];
        [_myTableView reloadData];
        index++;
    }else{
    
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataArray.count -1 inSection:0];
    [_myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


- (void)updateImageView:(NSTimer *)timer{
    if (_refreshView.hidden == YES) {
        [timer invalidate];
    }
    [UIView animateWithDuration:0.1 animations:^{
        //让_refreshView转动一周
        _refreshView.transform = CGAffineTransformRotate(_refreshView.transform, 1.0);
    }];
}


#pragma mark --UITableViewDelegate
//计算cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DXChatModel *model = [_dataArray objectAtIndex:indexPath.row];
    NSString *chatText = model.chatText;
    
    //返回能恰好容纳控件的高度
    return  [self caculatorHeightOfString:chatText].size.height+40;
}
#pragma mark - 计算字符串高度，用于label的高度自适应
-(CGRect)caculatorHeightOfString:(NSString *)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(200, 999)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                        context:nil];
    return rect;
}
#pragma mark --UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIde = @"chat";
    DXChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (cell == nil) {
        cell = [[DXChatCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];
    }
    DXChatModel *model = (DXChatModel *)[_dataArray objectAtIndex:indexPath.row];
    NSString *chatText = model.chatText;
    //计算字符串的size
    //font、lineBreakMode 字体的大小、换行方式(与字符串要赋值的UILabel一致)
    //constrainedToSize (计算的最大size的设定)
      CGRect rect = [self caculatorHeightOfString:chatText];
    //UILabel(绘制的最大高度10000像素)
    if (model.isSelf == YES) {
        cell.backgroundColor = [UIColor clearColor];
        //自己发送的消息(显示右边)
        cell.rightHeaderImageView.hidden=NO;
        cell.rightImageView.hidden = NO;
        cell.LeftHeaderImageView.hidden=YES;
        cell.leftImageView.hidden = YES;
        cell.rightLabel.text = chatText;
        //重新设定控件的frame
        cell.rightLabel.frame = CGRectMake(10,5, rect.size.width,rect.size.height);
        cell.rightImageView.frame = CGRectMake(SCREENW - rect.size.width- 20-60,10,rect.size.width +25, rect.size.height +13);
        
    }else{
        //对方说话
        cell.backgroundColor = [UIColor clearColor];
        cell.LeftHeaderImageView.hidden=NO;
        cell.leftImageView.hidden = NO;
        cell.rightHeaderImageView.hidden=YES;
        cell.rightImageView.hidden = YES;
        cell.leftLabel.text = chatText;
        cell.leftImageView.frame = CGRectMake(55, 10, rect.size.width +35,rect.size.height +20);
        cell.leftLabel.frame = CGRectMake(20,5,rect.size.width, rect.size.height);
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)dealloc{
    //[super dealloc];
    //移除self对广播的观察
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark --UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
