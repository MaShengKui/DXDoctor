//
//  DXQuestionAnswerController.h
//  DXDoctor
//
//  Created by Mask on 15/10/13.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DXQuestionAnswerController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSNumber *sort;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSNumber *articleId;
@end
