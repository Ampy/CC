//
//  LogicBase.m
//  CC
//
//  Created by fy ren on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "LogicBase.h"

@implementation LogicBase

+(NSMutableArray *)SqlToArray:(NSString *)sql FieldCount:(int) count
{
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    
    DatabaseHelper *db = [[DatabaseHelper alloc] init];
    [db OpenDB:[Settings Instance].DatabaseName];
    sqlite3_stmt * stmt= [db ExecSql:sql];
    while (sqlite3_step(stmt) == SQLITE_ROW) 
    {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for(int i=0;i<count;i++)
        {
            char* roadname  = (char*)sqlite3_column_text(stmt, i);
            if(roadname)
            {
                [arr addObject:[NSString stringWithUTF8String:roadname]];
            }
            else {
                [arr addObject:@""];
            }
        }
        [mArray addObject:arr];
    }
    
    return mArray;
}

+(void)SetArrayLevel3:(NSMutableArray *)arr Value:(NSString *)value Level1:(int)l1 Level2:(int)l2 Level3:(int)l3
{
    [[[arr objectAtIndex:l1] objectAtIndex:l2] setObject:value atIndex:l3];
}

+(void)UpdateByService
{
    //@"Inspect",@"InspectActivity",@"InspectItem",@"InspectScore",@"InspItemTemp",@"InspScoreTemp",@"InspTemp",@"UserLine",
    NSArray * arr = [NSArray arrayWithObjects:@"V_Line",@"V_Site",@"V_Segment",@"Sys_User",@"V_Inspect",nil];
    Update *u = [[Update alloc] init];
    [u UpdateAll:arr];
}

+(NSMutableArray *)Login:(NSString *)name Password:(NSString *)pwd
{
    NSMutableArray * arr = [[NSMutableArray alloc]init];;
    NSString * sql = [[NSString alloc] initWithFormat:@"select UserId,UserName from Sys_User where Name='%@' and Password='%@' ",name,[Common MD5:pwd]];
    DatabaseHelper *db = [[DatabaseHelper alloc] init];
    //Settings *st =[Settings Instance];
    [db OpenDB:[Settings Instance].DatabaseName];
    sqlite3_stmt * stmt= [db ExecSql:sql];
    if(sqlite3_step(stmt) == SQLITE_ROW)
    {
        [arr addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 0)]];
        [arr addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 1)]];
    }
    [db CloseDB];
    return arr;
}



+(NSMutableArray *)GetInspectList1
{
    NSString * sql = [NSString stringWithFormat:@"select LineName,SegmentName,SiteName,InspectWay,InspectDate,Total from V_Inspect where Finished='1' and Recorder='%@'",[Config GetPlistInfo:@"LoginUserId"]];
    return [self SqlToArray:sql FieldCount:6];
}

+(NSMutableArray *)GetInspectList2
{
    NSString * sql = [NSString stringWithFormat:@"select LineName,SegmentName,SiteName,InspectWay,InspectDate,Total from V_Inspect where Finished='0' and Recorder='%@'",[Config GetPlistInfo:@"LoginUserId"]];
    return [self SqlToArray:sql FieldCount:6];
}

+(NSMutableArray *)GetLine
{
    //NSString * sql = [NSString stringWithFormat:@"select * from V_Line where UserId='%@'",[Config GetPlistInfo:@"LoginUserId"]];
    NSString * sql = [NSString stringWithFormat:@"select * from V_Line"];
    return[self SqlToArray:sql FieldCount:4];
}

+(NSMutableArray *)GetSegment
{
    NSString * sql = [NSString stringWithFormat:@"select * from V_Segment where LineID='%@'",[Config GetPlistInfo:@"LineID"]];
    return [self SqlToArray:sql FieldCount:4];
}

+(NSMutableArray *)GetSite
{
    NSString * sql = [NSString stringWithFormat:@"select * from V_Site where SegmentID='%@'",[Config GetPlistInfo:@"SegmentID"]];
    return [self SqlToArray:sql FieldCount:6];
}

@end
