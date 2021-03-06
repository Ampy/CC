//
//  Update.m
//  文明施工
//
//  Created by fy ren on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Update.h"

@implementation Update

-(int)GetTableStruct:(NSString *)tableName
{
  DatabaseHelper *db = [[DatabaseHelper alloc] init];
  [db OpenDB:[Settings DatabaseName]];
  [db BeginTransaction];
  
  CellService * cs = [[CellService alloc] init];
  NSString * sql = [cs CellWeb:[@"IOS/GetTableStruct?tableName=" stringByAppendingString:tableName]];
  
  if(!sql) return 22;
  
  [db ExecSql:sql];
  [db Setp];
  [db Final];
  [db Commit];
  [db CloseDB];
  
  return 1;
}

-(int)GetTableData:(NSString *)tableName
{
  
  DatabaseHelper *db = [[DatabaseHelper alloc] init];
  [db OpenDB:[Settings DatabaseName]];
  @try {
    NSString *delSql = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@ ",tableName];
    [db ExecSql:delSql];
    [db Setp];
    [db Final];
    
    int returnCode=[self GetTableStruct:tableName];
    if(returnCode!=1) return returnCode;
    
    [db BeginTransaction];
    
    CellService * cs = [[CellService alloc] init];
    NSString * sqls = [cs CellWeb:[@"IOS/GetTableData?tableName=" stringByAppendingString:tableName]];
    
 
    
    
    if(!sqls) return 22;
    
    //    NSArray * array = [sqls componentsSeparatedByString:@"|$|"];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[sqls componentsSeparatedByString:@"|$|"]];
    
    int count=array.count-1;
    for(int i=count;i>=0;i--)
    {
  
        [db ExecSql:[array objectAtIndex:i]];
        [db Setp];
        [db Final];
      @autoreleasepool {
        [array removeObjectAtIndex:i];
      }
    }

  }
  @catch (NSException *exception) {
    NSLog(@"更新异常：%@",exception.name);
    NSLog(@"更新异常：%@",exception.reason);
  }
  @finally {
    [db Commit];
    [db CloseDB];
  }
  //
  
  return 1;
  
}

-(int)GetSiteInspect:(NSString *)sID
{
  DatabaseHelper *db = [[DatabaseHelper alloc] init];
  [db OpenDB:[Settings DatabaseName]];
  [db BeginTransaction];
  
  CellService * cs = [[CellService alloc] init];
  NSString * sqls = [cs CellWeb:[@"IOS/GetSiteInspect?ID=" stringByAppendingString:sID]];
  
  if(!sqls) return 22;
  
  NSArray * array = [sqls componentsSeparatedByString:@"|$|"];
  for(id sql in array)
  {
    [db ExecSql:sql];
    [db Setp];
    [db Final];
  }
  [db Commit];
  [db CloseDB];
  
  return 1;
}

-(int)GetAccord
{
  DatabaseHelper *db = [[DatabaseHelper alloc] init];
  [db OpenDB:[Settings DatabaseName]];
  [db BeginTransaction];
  
  CellService * cs = [[CellService alloc] init];
  
  NSString * sqls = [cs CellWeb:[@"IOS/GetAccord" stringByAppendingString:@"" ]];
  
  
  
  if(!sqls) return 22;
  
  NSArray * array = [sqls componentsSeparatedByString:@"|$|"];
  
 
  for(id sql in array)
  {
    [db ExecSql:sql];
    [db Setp];
    [db Final];
  }
  [db Commit];
  [db CloseDB];
  
  return 1;
}

-(int)GetTableStructs:(NSArray *)tableNames
{
  int returnCode = 1;
  for(id name in tableNames)
  {
    returnCode = [self GetTableStruct:name];
    if(returnCode!=1) return returnCode;
  }
  return returnCode;
}

-(int)UpdateAll:(NSArray *)tableNames
{
  int returnCode = 1;
  for(id name in tableNames)
  {
    //returnCode = [self GetTableStruct:name];
    //if(returnCode!=1) return returnCode;
    @autoreleasepool {
 
      returnCode = [self GetTableData:name];
 
    }
    if(returnCode!=1) return returnCode;
  }
  return returnCode;
}

@end
