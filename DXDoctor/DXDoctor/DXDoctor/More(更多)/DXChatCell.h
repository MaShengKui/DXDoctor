//
//  DXChatCell.h
//  DXDoctor
//
//  Created by Mask on 15/10/15.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DXChatCell : UITableViewCell
//如果说cell中的控件，需要在类外，频繁的对控件进行调用（修改控件的frame、值等）,可以将控件作为cell的属性
//显示右侧的聊天气泡图片

@property (nonatomic,strong) UIImageView *rightImageView;
//显示右侧的聊天内容
@property (nonatomic,strong) UILabel *rightLabel;

@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *leftLabel;

@property (nonatomic,strong) UIImageView *LeftHeaderImageView;
@property (nonatomic,strong) UIImageView *rightHeaderImageView;
@property(nonatomic,strong) UIImageView *leftHeaderImageView;
@end
