//
//  DXChatCell.m
//  DXDoctor
//
//  Created by Mask on 15/10/15.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXChatCell.h"
@interface DXChatCell ()
//ui布局
- (void)uiConfig;
@end
@implementation DXChatCell
@synthesize rightImageView=_rightImageView,rightLabel=_rightLabel,leftImageView=_leftImageView,leftLabel=_leftLabel;


- (void)awakeFromNib {
    [super awakeFromNib];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //在这调用方法
        [self uiConfig];
    }
    return self;
}
- (void)uiConfig{
    
    _LeftHeaderImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40,40)];
    _LeftHeaderImageView.image=[UIImage imageNamed:@"DxyAvatar"];
    [self.contentView addSubview:_LeftHeaderImageView];
    
    _rightHeaderImageView=[[UIImageView alloc] initWithFrame:CGRectMake(SCREENW-50, 10, 40, 40)];
    _rightHeaderImageView.image=[UIImage imageNamed:@"user"];
    [self.contentView addSubview:_rightHeaderImageView];
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENW-60,10,20,30)];
    UIImage *right = [UIImage imageNamed:@"chat_to_bg_normal"];
    //当图片拉伸到一定大小后，再进行拉伸会从左侧30像素之后、顶部35像素之后，进行拉伸。
    right = [right stretchableImageWithLeftCapWidth:30 topCapHeight:35];
    _rightImageView.image = right;
    [self.contentView addSubview:_rightImageView];
    _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5,80, 5)];
    _rightLabel.numberOfLines = 0;
    _rightLabel.lineBreakMode = NSLineBreakByCharWrapping;//中、英文混合的字符串
    _rightLabel.backgroundColor = [UIColor clearColor];
    _rightLabel.font = [UIFont systemFontOfSize:14];
    _rightLabel.textColor=[UIColor whiteColor];
    [_rightImageView addSubview:_rightLabel];
    
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60,10,20,30)];
    UIImage*left = [UIImage imageNamed:@"ReceiverTextNodeBkg.png"];
    left = [left stretchableImageWithLeftCapWidth:30 topCapHeight:35];
    _leftImageView.image = left;
    [self.contentView addSubview:_leftImageView];
    
    _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,5,5,5)];
    _leftLabel.numberOfLines = 0;
    _leftLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _leftLabel.backgroundColor = [UIColor  clearColor];
    _leftLabel.font = [UIFont systemFontOfSize:14];
    [_leftImageView addSubview:_leftLabel];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
