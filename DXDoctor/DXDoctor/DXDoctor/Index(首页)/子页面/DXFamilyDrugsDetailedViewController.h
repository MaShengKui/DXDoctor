//
//  DXFamilyDrugsDetailedViewController.h
//  DXDoctor
//
//  Created by msk on 16/4/18.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXFamilyDrugsModel.h"

@interface DXFamilyDrugsDetailedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *nameTextView;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;
@property(nonatomic,strong) DXFamilyDrugsModel *model;

@end
