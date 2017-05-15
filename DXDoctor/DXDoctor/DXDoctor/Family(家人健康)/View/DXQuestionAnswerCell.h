//
//  DXQuestionAnswerCell.h
//  DXDoctor
//
//  Created by Mask on 15/10/13.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXQuestionAnswerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (nonatomic, strong) DXQuestionAnswerModel *model;
@end
