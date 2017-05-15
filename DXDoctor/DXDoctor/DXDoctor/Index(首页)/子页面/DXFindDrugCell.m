//
//  DXFindDrugCell.m
//  DXDoctor
//
//  Created by Mask on 15/10/9.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXFindDrugCell.h"

@implementation DXFindDrugCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//    if (selected) {
//     self.bgImageView.image = [UIImage imageNamed:@"NumberBgOrg"];
//    } else{
//    
//        return;
//    }
//}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{

    [super setHighlighted:highlighted animated:animated];
    

}
- (void)setModel:(DXFindDrugModel *)model{

    _model = model;
    self.nameLabel.text = _model.name;
    self.desct.text = _model.descr;
    
}
#if 0
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    if (selected) {
        [self.merchantTitle setHighlighted:NO];
        [self.merchantDescription setHighlighted:NO];
        [self.merchantAddress setHighlighted:NO];
        [self.distance setHighlighted:NO];
    } }
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        [self.merchantTitle setHighlighted:NO];
        [self.merchantDescription setHighlighted:NO];
        [self.merchantAddress setHighlighted:NO];
        [self.distance setHighlighted:NO];
    }
    }
#endif
@end
