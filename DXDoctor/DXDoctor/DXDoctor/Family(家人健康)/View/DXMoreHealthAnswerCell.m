//
//  DXMoreHealthAnswerCell.m
//  DXDoctor
//
//  Created by Mask on 15/10/12.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXMoreHealthAnswerCell.h"
@interface DXMoreHealthAnswerCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;

@end
@implementation DXMoreHealthAnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.moreLabel.text = @"查看更多文章";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
