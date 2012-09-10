//
//  LogicBase.m
//  CC
//
//  Created by fy ren on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "LogicBase.h"

@implementation LogicBase

+(NSString *)Login:(NSString *)name Password:(NSString *)pwd
{
    NSString * returnValue = @"F";
    NSString * sql = [[NSString alloc] initWithFormat:@"select UserName from Sys_User where Name='%@' and Password='%@' ",name,[Common MD5:pwd]];
    DatabaseHelper *db = [[DatabaseHelper alloc] init];
    Settings *st =[Settings Instance];
    [db OpenDB:[Settings Instance].DatabaseName];
    sqlite3_stmt * stmt= [db ExecSql:sql];
    if(sqlite3_step(stmt) == SQLITE_ROW)
    {
        char* roadname  = (char*)sqlite3_column_text(stmt, 0);
        returnValue = [NSString stringWithUTF8String:roadname];
    }
    [db CloseDB];
    return returnValue;
}

@end
