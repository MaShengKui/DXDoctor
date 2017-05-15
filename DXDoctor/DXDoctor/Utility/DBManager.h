//
//  DBManager.h
//  CloverDoctor
//
//  Created by Mask on 15-3-1.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DBManager : NSObject

+(instancetype)shareManager;
- (instancetype)init;


/**
 @brief 文章表数据操作方法
 */

//插入数据用的方法 参数是根据表里插入的字段决定的
-(void)insertArticleWithArticleId:(NSString *)articleId imageData:(NSData *)imageData articleTitle:(NSString *)articleTitle WithOthers:(NSString *)other;

//取消收藏 - 从数据库里删除数据
-(void)deleteArticleWithArticleId:(NSString *)articleId;

//查询当前的表下一共有多少数据 然后返回值 就是收藏页面的数据源
-(NSMutableArray*)selectFromTable;

//按照id去查找 如果数据库中有返回yes 如果没有找到则返回NO 由此来决定到底是收藏还是取消收藏
- (BOOL)selectFormTableWithArticleId:(NSString *)articleId;


/**
 @brief 药品表数据操作方法
 */
-(BOOL)insertDrugWithDrugId:(NSString *)drugId showName:(NSString *)showName remark:(NSString *)remark;
-(void)deleteDrugWithDrugId:(NSString *)drugId;
-(NSMutableArray*)selectFromDrugTable;
- (BOOL)selectFormDrugTableWithDrugId:(NSString *)drugId;
-(BOOL)updateDrugInfoWithDrugId:(NSString *)drugId showName:(NSString *)showName remark:(NSString *)remark;
@end
