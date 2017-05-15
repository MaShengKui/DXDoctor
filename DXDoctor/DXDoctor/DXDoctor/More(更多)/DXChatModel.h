//
//  DXChatModel.h
//  DXDoctor
//
//  Created by Mask on 15/10/15.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXChatModel : NSObject
//聊天的内容
@property (nonatomic,copy) NSString *chatText;
//用于标记，消息来自于电脑还是自己(自己 YES)
@property (nonatomic,assign) BOOL isSelf;

@end
