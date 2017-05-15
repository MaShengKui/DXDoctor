//
//  DXHealthTestCell.h
//  DXDoctor
//
//  Created by Mask on 15/10/14.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXHealthTestCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (nonatomic, strong) DXHealthTestModel *model ;
@end
