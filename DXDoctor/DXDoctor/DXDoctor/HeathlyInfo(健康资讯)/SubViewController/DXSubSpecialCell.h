//
//  DXSubSpecialCell.h
//  DXDoctor
//
//  Created by Mask on 15/9/26.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXSubSpecialModel.h"
#import "DXTruthModel.h"
@interface DXSubSpecialCell : UITableViewCell

@property (nonatomic, strong) DXSubSpecialModel *model;
@property (nonatomic, strong) DXTruthModel *truthModel;
@end
