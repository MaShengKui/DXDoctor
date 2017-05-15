//
//  DXRelateArticleCell.m
//  DXDoctor
//
//  Created by Mask on 15/10/12.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DXRelateArticleCell.h"
#import "UIImageView+AFNetworking.h"
@interface DXRelateArticleCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desctLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picView;


@end
@implementation DXRelateArticleCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DXRelateArticleModel *)model{

    _model = model;
   
    self.titleLabel.text = _model.article_title;
    self.desctLabel.text = _model.search_content_hl;
    [self.picView setImageWithURL:[NSURL URLWithString:_model.cover_small] placeholderImage:[UIImage imageNamed:@"NewsImgBg"]];
}


@end
