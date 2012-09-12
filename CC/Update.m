//
//  Update.m
//  文明施工
//
//  Created by fy ren on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Update.h"

@implementation Update

-(void)GetTableStruct:(NSString *)tableName
{
    DatabaseHelper *db = [[DatabaseHelper alloc] init];
    [db OpenDB:[Settings Instance].DatabaseName];
    //[db BeginTransaction];
    
    NSString *delSql = [[NSString alloc] initWithFormat:@"DROP TABLE IF EXISTS %@ ",tableName];
    [db ExecSql:delSql];
    [db Setp];
    
    CellService * cs = [[CellService alloc] init];
    NSString * sql = [cs CellWeb:[@"IOS/GetTableStruct?tableName=" stringByAppendingString:tableName]];
    
    [db ExecSql:sql];
    [db Setp];
    [db Commit];
    [db CloseDB];
}

-(void)GetTableData:(NSString *)tableName
{
    DatabaseHelper *db = [[DatabaseHelper alloc] init];
    [db OpenDB:[Settings Instance].DatabaseName];
    [db BeginTransaction];
    
    CellService * cs = [[CellService alloc] init];
    NSString * sqls = [cs CellWeb:[@"IOS/GetTableData?tableName=" stringByAppendingString:tableName]];
    NSArray * array = [sqls componentsSeparatedByString:@"|$|"];
    int i=1;
    for(id sql in array)
    {
        i++;
        [db ExecSql:sql];
        [db Setp];
    }
    [db Commit];
    [db CloseDB];
}

-(void)GetTableStructs:(NSArray *)tableNames
{
    for(id name in tableNames)
    {
        [self GetTableStruct:name];
    }
}

-(void)UpdateAll:(NSArray *)tableNames
{
    for(id name in tableNames)
    {
        [self GetTableStruct:name];
        [self GetTableData:name];
    }
}

@end
