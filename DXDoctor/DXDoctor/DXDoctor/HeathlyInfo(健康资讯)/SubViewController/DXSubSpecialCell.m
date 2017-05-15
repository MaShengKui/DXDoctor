//
//  DXSubSpecialCell.m
//  DXDoctor
//
//  Created by Mask on 15/9/26.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXSubSpecialCell.h"
#import "UIImageView+AFNetworking.h"
@interface DXSubSpecialCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end
@implementation DXSubSpecialCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DXSubSpecialModel *)model{
    _model = model;
    self.titleLabel.text = _model.title;
    
    [self.iconImage setImageWithURL:[NSURL URLWithString:_model.cover_small] placeholderImage:[UIImage imageNamed:@"NewsImgBg"]];
}
- (void)setTruthModel:(DXTruthModel *)truthModel{
    _truthModel = truthModel;
    self.titleLabel.text = _truthModel.title;
    
    [self.iconImage setImageWithURL:[NSURL URLWithString:_truthModel.cover_small] placeholderImage:[UIImage imageNamed:@"NewsImgBg"]];
}

@end
