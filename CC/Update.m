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
    
    NSString *delSql = [[NSString alloc] initWithFormat:@"drop table %@ ",tableName];
    [db ExecSql:delSql];
    [db Setp];
    
    CellService * cs = [[CellService alloc] init];
    NSString * sql = [cs CellWeb:[@"IOS/GetTableStruct?tableName=" stringByAppendingString:tableName]];
    
    [db ExecSql:sql];
    [db Setp];
    [db CloseDB];
}

-(void)GetTableData:(NSString *)tableName
{
    DatabaseHelper *db = [[DatabaseHelper alloc] init];
    [db OpenDB:[Settings Instance].DatabaseName];
    
    CellService * cs = [[CellService alloc] init];
    NSString * sqls = [cs CellWeb:[@"IOS/GetTableData?tableName=" stringByAppendingString:tableName]];
    NSArray * array = [sqls componentsSeparatedByString:@"|$|"];
    for(id sql in array)
    {
        [db ExecSql:sql];
        [db Setp];
    }
    [db CloseDB];
}

@end
