//
//  DXNewInfoCell.m
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXNewInfoCell.h"
#import "UIImageView+AFNetworking.h"

@interface DXNewInfoCell()

@property (weak, nonatomic)IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic)IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
@property (weak, nonatomic) IBOutlet UILabel *pubdate;

@property (weak, nonatomic) IBOutlet UILabel *authorRemarkLabel;

@end

@implementation DXNewInfoCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DXNewInfoModel *)model{

    _model = model;
    _titleLabel.text = _model.title;
    [_iconImage setImageWithURL:[NSURL URLWithString:_model.cover_small]placeholderImage:[UIImage imageNamed:@"NewsImgBg"]];
    [_authorImage setImageWithURL:[NSURL URLWithString:_model.author_avatar]placeholderImage:[UIImage imageNamed:@"NewsImgBg"]];
    _author.text = [NSString stringWithFormat:@"作者: %@",_model.author];
    _pubdate.text = _model.publish_time;
    _authorRemarkLabel.text = _model.author_remarks;
    
    _authorImage.layer.cornerRadius = 10;
    _authorImage.layer.masksToBounds = YES;
}

@end
