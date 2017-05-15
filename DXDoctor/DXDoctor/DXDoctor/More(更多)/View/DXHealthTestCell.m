//
//  DXHealthTestCell.m
//  DXDoctor
//
//  Created by Mask on 15/10/14.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXHealthTestCell.h"

@implementation DXHealthTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}
- (void)setModel:(DXHealthTestModel *)model{

    _model = model;
    [self.picView setImageWithURL:[NSURL URLWithString:_model.picPath] placeholderImage:[UIImage imageNamed:@"NewsImgBg"]];
    self.picView.layer.cornerRadius = 10;
    self.picView.layer.masksToBounds = YES;
    self.titleLabel.text = _model.title;
    self.summaryLabel.text = _model.subTitle;
}

@end
