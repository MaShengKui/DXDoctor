//
//  DXFindDrugCell.h
//  DXDoctor
//
//  Created by Mask on 15/10/9.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXFindDrugModel.h"
@interface DXFindDrugCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desct;

@property (nonatomic, strong) DXFindDrugModel *model ;

@end
