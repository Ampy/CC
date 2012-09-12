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
    NSArray * arr = [NSArray arrayWithObjects:@"V_Line",@"V_Site",@"V_Segment",@"Sys_User",@"V_Inspect",@"SiteInspTemp",@"SiteInspItemTemp",@"SiteScoreTemp",nil];
    
    NSArray * structTables = [NSArray arrayWithObjects:@"Inspect",@"InspectItem",@"InspectScore",@"InspectActivity",nil];
    
    Update *u = [[Update alloc] init];
    [u UpdateAll:arr];
    [u GetTableStructs:structTables];
    
    NSString *sql = [NSString stringWithString:@"CREATE view IF NOT EXISTS V_Inspect1 as select a.InspectID, a.InspTempID,a.InspectCode,a.Name,a.SiteID, a.InspType,a.InspectWay,a.InspectDate,a.Total,a.Score,a.Finished, a.Inspecter,a.Recorder,a.RecordDate, b.Name SiteName, c.SegmentID,c.Name SegmentName, d.LineID,d.Name LineName ,a.InspTempWeight from inspect a left join V_Site b on a.SiteID = b.SiteID left join V_Segment c on b.SegmentID = c.Segmentid left join V_Line d on c.LineID=d.LineID"];
    
    DatabaseHelper *db = [[DatabaseHelper alloc] init];
    [db OpenDB:[Settings Instance].DatabaseName];
    sqlite3_stmt * stmt= [db ExecSql:sql];
    sqlite3_step(stmt);
    [db CloseDB];
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

+(void)BuildCheckData
{
    DatabaseHelper *db = [[DatabaseHelper alloc] init];
    [db OpenDB:[Settings Instance].DatabaseName];

    NSString * SiteID = [NSString stringWithString:[Config GetPlistInfo:@"SiteID"]];
    NSString * InspectDate = [NSString stringWithString:[Config GetPlistInfo:@"InspectDate"]];
    NSString * InspectActivityID = [Common GetGuid];
    NSString * InspectID;
    NSString * SiteInspectID;
    //
    NSString * sql1 = [NSString stringWithFormat:@"insert into InspectActivity (InspectActivityID,InspectWay,SiteID,Inspecter,InspectDate,Recorder,RecordDate,RealInspectDate) values('%@','%@','%@','%@','%@','%@','%@','%@')",InspectActivityID,[Config GetPlistInfo:@"InspectWay"],SiteID,[Config GetPlistInfo:@"LoginUserName"],InspectDate,[Config GetPlistInfo:@"LoginUserId"],InspectDate,InspectDate];
    sqlite3_stmt * stmt1= [db ExecSql:sql1];
    sqlite3_step(stmt1);
    
    NSString * sql2 = [NSString stringWithFormat:@"select * from SiteInspTemp where SiteID='%@'",SiteID];
    sqlite3_stmt * stmt2= [db ExecSql:sql2];
    if(sqlite3_step(stmt2) == SQLITE_ROW)
    {
        InspectID = [Common GetGuid];
        SiteInspectID = [NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 0)]];
        NSString * sql = [NSString stringWithFormat:@"insert into Inspect (InspectID,InspectActivityID,SiteInspTempID,Finished,IsCancel,SiteID,InspTempID,Name,Optional,InspType,Remarks,Sort,invalid,InspTempWeight,InspCategory) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                          InspectID,InspectActivityID,SiteInspectID,@"0",@"0",
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 1)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 2)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 3)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 4)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 5)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 6)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 7)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 8)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 9)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 10)]];
        sqlite3_stmt * stmt= [db ExecSql:sql];
        sqlite3_step(stmt);
    }
    
    sql2 = [NSString stringWithFormat:@"select * from SiteInspItemTemp where SiteInspTempID='%@'",SiteInspectID];
    stmt2= [db ExecSql:sql2];
    while(sqlite3_step(stmt2) == SQLITE_ROW)
    {
        NSString * sql = [NSString stringWithFormat:@"insert into InspectItem (InspectItemID,InspectID,SiteInspItemTempID,ItemTempID,PItemTempID,Name,Remarks,SpecialItem,Score,Sort,InspTempID,SiteInspTempID) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",[Common GetGuid],InspectID,
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 0)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 1)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 2)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 3)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 4)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 5)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 6)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 7)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 8)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 9)]];
        sqlite3_stmt * stmt= [db ExecSql:sql];
        sqlite3_step(stmt);
    }

    
    sql2 = [NSString stringWithFormat:@"select * from SiteScoreTemp where SiteInspTempID='%@'",SiteInspectID];
    stmt2= [db ExecSql:sql2];
    while(sqlite3_step(stmt2) == SQLITE_ROW)
    {
        NSString * sql = [NSString stringWithFormat:@"insert into InspectScore (ScoreID,InspectID,SiteScoreTempID,InspScoreTempID,Name,Caption,Score,Sort,InspItemTempID,InspTempID,SiteInspItemTempID,SiteInspTempID,Qualified) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",[Common GetGuid],InspectID,
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 0)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 1)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 2)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 3)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 4)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 5)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 6)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 7)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 8)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 9)],
                          [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 10)]];
        sqlite3_stmt * stmt= [db ExecSql:sql];
        sqlite3_step(stmt);
    }

    
    [db CloseDB];
}

@end
