//
//  DXQuestionAnswerCell.m
//  DXDoctor
//
//  Created by Mask on 15/10/13.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXQuestionAnswerCell.h"
@interface DXQuestionAnswerCell()


@end
@implementation DXQuestionAnswerCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DXQuestionAnswerModel *)model{

    _model = model;
    self.titleLabel.text = _model.title;
    self.contentLabel.text = _model.content;
    self.numberLabel.text = [_model.sort stringValue];
    self.bgView.image = [UIImage imageNamed:@"NumberBg"];
    self.iconView.image = [UIImage imageNamed:@"ArrowIconGray"];
}

@end
