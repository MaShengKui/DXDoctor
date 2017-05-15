//
//  DBManager.m
//  CloverDoctor
//
//  Created by Mask on 15-3-1.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "DXFavoriteModel.h"
#import "DXFamilyDrugsModel.h"
@implementation DBManager
{
    FMDatabase *_dataBase;
    NSMutableArray *_modelArray;
    NSMutableArray *_drugModelArray;

}

+(DBManager*)shareManager{
    static DBManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //实例化本类对象
        manager = [[DBManager alloc] init];
    });
    return manager;

}

-(instancetype)init{
    self=[super init];
    if(self){
        NSString *Path=[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/articleDrug.db"];
        _dataBase=[[FMDatabase alloc] initWithPath:Path];
        if([_dataBase open]){
            NSLog(@"数据库创建成功");
        }
        
        //给数据库建表
        //创建文章表
        NSString *createTableSql = @"create table if not exists articleTable(id integer primary key autoincrement, articleId varchar(256), coverdata blob, title varchar(256), other varchar(256))";
        
        //创建药品表
        NSString *createDrugTableSql = @"create table if not exists drugTable(id integer primary key autoincrement, drugId varchar(256), showName varchar(256), remark varchar(256))";
        
        if ([_dataBase executeUpdate:createTableSql]&&[_dataBase executeUpdate:createDrugTableSql]) {
            NSLog(@"表创建成功");
        }
        _modelArray = [[NSMutableArray alloc] init];
        _drugModelArray=[[NSMutableArray alloc] init];
        
    }
    return self;
}

#pragma mark - 文章表的相关数据库操作
//插入数据用的方法 参数是根据表里插入的字段决定的
-(void)insertArticleWithArticleId:(NSString *)articleId imageData:(NSData *)imageData articleTitle:(NSString *)articleTitle WithOthers:(NSString *)other{
    NSString *insertSql= @"insert into articleTable(articleId,coverdata,title, other) values(?,?,?,?)";
    BOOL isSuccessed = [_dataBase executeUpdate:insertSql,articleId,imageData,articleTitle, other];
    if (isSuccessed) {
        NSLog(@"收藏成功！！！！");
       
    }
}
//取消收藏 - 从数据库里删除数据
-(void)deleteArticleWithArticleId:(NSString *)articleId{
    NSString *deleteSql=@"delete from articleTable where articleId=?";
    if ([_dataBase executeUpdate:deleteSql,articleId]) {
        NSLog(@"取消收藏成功");
    }
}

-(NSMutableArray*)selectFromTable{
    [_modelArray removeAllObjects];
    
    NSString *selected=@"select *from articleTable";
    FMResultSet *set=[_dataBase executeQuery:selected];
    while ([set next]) {
        DXFavoriteModel *model = [[DXFavoriteModel  alloc] init];
        model.articleId = [set stringForColumn:@"articleId"];
        model.coverData = [set dataForColumn:@"coverdata"];
        model.title = [set stringForColumn:@"title"];
        model.other= [set stringForColumn:@"other"];
        [_modelArray addObject:model];
    }
    return _modelArray;
}
- (BOOL)selectFormTableWithArticleId:(NSString *)articleId{

    NSString *selectSql = @"select * from articleTable where articleId=? ";
    FMResultSet *set = [_dataBase executeQuery:selectSql,articleId];
    while ([set next]) {
        return  YES;
    }
    return NO;
}

#pragma mark - 药品表的相关数据库操作
//插入数据用的方法 参数是根据表里插入的字段决定的
-(BOOL)insertDrugWithDrugId:(NSString *)drugId showName:(NSString *)showName remark:(NSString *)remark{
    NSString *insertSql= @"insert into drugTable(drugId,showName,remark) values(?,?,?)";
    BOOL isSuccessed = [_dataBase executeUpdate:insertSql,drugId,showName,remark];
    
    if (isSuccessed) {
        NSLog(@"插入药品信息成功！！！！");
    }
    return isSuccessed;
}

//取消收藏 - 从数据库里删除数据
-(void)deleteDrugWithDrugId:(NSString *)drugId{
    NSString *deleteSql=@"delete from drugTable where drugId=?";
    if ([_dataBase executeUpdate:deleteSql,drugId]) {
        NSLog(@"删除药品信息成功");
    }
}

-(NSMutableArray*)selectFromDrugTable{
    [_drugModelArray removeAllObjects];
    
    NSString *selected=@"select *from drugTable";
    FMResultSet *set=[_dataBase executeQuery:selected];
    while ([set next]) {
        DXFamilyDrugsModel *model = [[DXFamilyDrugsModel  alloc] init];
        model.drugId = [set stringForColumn:@"drugId"];
        model.showName = [set stringForColumn:@"showName"];
        model.remark = [set stringForColumn:@"remark"];
        [_drugModelArray addObject:model];
    }
    return _drugModelArray;
}
- (BOOL)selectFormDrugTableWithDrugId:(NSString *)drugId{
    
    NSString *selectSql = @"select * from drugTable where drugId=? ";
    FMResultSet *set = [_dataBase executeQuery:selectSql,drugId];
    while ([set next]) {
        return  YES;
    }
    return NO;
}
-(BOOL)updateDrugInfoWithDrugId:(NSString *)drugId showName:(NSString *)showName remark:(NSString *)remark{
    
    NSString *sql1 = [NSString stringWithFormat: @"UPDATE drugTable SET %@='%@' WHERE drugId = '%@'",@"showName",showName,drugId];
    NSString *sql2 = [NSString stringWithFormat: @"UPDATE drugTable SET %@='%@' WHERE drugId = '%@'",@"remark",remark,drugId];
    
    BOOL isSuccessed=[_dataBase executeUpdate:sql1]&&[_dataBase executeUpdate:sql2];
    if (isSuccessed) {
        NSLog(@"修改药品信息成功啦，亲");
    }
    return isSuccessed;
}

@end
