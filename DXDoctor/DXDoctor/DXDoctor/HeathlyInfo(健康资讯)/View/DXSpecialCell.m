//
//  DXSpecialCell.m
//  DXDoctor
//
//  Created by Mask on 15/9/25.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXSpecialCell.h"
#import "UIImageView+AFNetworking.h"
@interface DXSpecialCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@end
@implementation DXSpecialCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DXSpecialModel *)model{

    _model =  model;
    _title.text = _model.name;
    [_iconImage setImageWithURL:[NSURL URLWithString:_model.cover_small] placeholderImage:[UIImage imageNamed:@"NewsImgBg"]];
    _desLabel.text = _model.desc;
    _timeLab.text=_model.create_time;
    
}

@end
