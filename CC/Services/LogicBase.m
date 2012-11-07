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
    [db OpenDB:[Settings DatabaseName]];
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
    [db Final];
    [db CloseDB];
    return mArray;
}

+(void)SetArrayLevel3:(NSMutableArray *)arr Value:(NSString *)value Level1:(int)l1 Level2:(int)l2 Level3:(int)l3
{
    [[[arr objectAtIndex:l1] objectAtIndex:l2] setObject:value atIndex:l3];
}

+(int)UpdateByService
{
    int returnCode = 1;
    
    CellService * cs = [[CellService alloc] init];
    NSString * url = [cs CellWeb:@"IOS/GetServiceUrl"];
    if(!url) return 0;
    if([url length]<50)
        [Settings setServiceUrl:url];
    
    NSArray * fullArr = [NSArray arrayWithObjects:@"V_Line",@"V_Site",@"V_Segment",@"Sys_User",@"V_Inspect",@"SiteInspTemp",@"SiteInspItemTemp",@"SiteScoreTemp",@"UserLine",nil];
    
    NSArray * arr = [NSArray arrayWithObjects:@"V_Line",@"V_Site",@"V_Segment",@"Sys_User",@"UserLine",nil];
    //struct
    NSArray * structTables = [NSArray arrayWithObjects:@"Inspect",@"InspectItem",@"InspectScore",@"InspectActivity",@"V_Site_H",nil];
    Update *u = [[Update alloc] init];
    
    DatabaseHelper *db = [[DatabaseHelper alloc] init];
    NSString *n=[Settings DatabaseName];
    [db OpenDB:n];
    
    //init db
    if([@"F" isEqualToString:[Settings IsInit]])
    {
        
        returnCode = [u UpdateAll:fullArr];
        if(returnCode!=1) return returnCode;
        
        returnCode = [u GetTableStructs:structTables];
        if(returnCode!=1) return returnCode;
        
        NSString *sql = @"CREATE view IF NOT EXISTS V_InspectActivity as select a.InspectActivityID,a.InspectCode,a.Name,a.SiteID,a.InspectWay,a.InspectDate,a.Total,a.Score,a.Finished,a.Inspecter,a.Recorder,a.RecordDate,b.Name SiteName,c.SegmentID,c.Name SegmentName,d.LineID,d.Name LineName from inspectactivity a left join V_Site b on a.SiteID = b.SiteID left join V_segment c on b.SegmentID = c.segmentid left join V_Line d on c.LineID=d.LineID ";
        
        NSString *sql2=@"CREATE view IF NOT EXISTS  V_VerifyInspect as select c.InspectActivityID,a.inspectid,a.inspectitemid,a.Selected,b.IsCancel from (select inspectid,inspectitemid,sum(selected) selected from InspectScore group by inspectid,inspectitemid) a left join  InspectItem b on a.inspectitemid = b.inspectitemid left join inspect c on b.inspectid = c.inspectid";
        
        [db ExecSql:sql];
        [db Setp];
        [db Final];
        
        [db ExecSql:sql2];
        [db Setp];
        [db Final];
        
        //[Config SetPlistInfo:@"IsInit" Value:@"T"];
        [Settings setIsInit:@"T"];
    }
    else
    {
        NSString *delbackSql = @"delete from V_Site_H ";
        [db ExecSql:delbackSql];
        [db Setp];
        [db Final];
        
        NSString *backSql = @"insert into V_Site_H select * from V_Site";
        [db ExecSql:backSql];
        [db Setp];
        [db Final];
        
        returnCode = [u UpdateAll:arr];
        if(returnCode!=1) return returnCode;
        
        returnCode = [u GetAccord];
        if(returnCode!=1) return returnCode;
        
        NSString *sql = @"select SiteID from V_Site where SiteID not in (select a.SiteID  from V_Site a inner join V_Site_H b on a.SiteID=b.SiteID and a.Version=b.Version )";
        
        NSMutableArray * arr = [self SqlToArray:sql FieldCount:1];
        for(int i=arr.count-1;i>=0;i--)
        {
            NSString * sID = [[arr objectAtIndex:i] objectAtIndex:0];
            NSString *delSQL = [NSString stringWithFormat:@"delete from SiteInspTemp where SiteID='%@' |$| delete from SiteInspItemTemp where SiteInspTempID in (select SiteInspTempID from SiteInspTemp where SiteID='%@') |$| delete from SiteScoreTemp where SiteInspTempID in (select SiteInspTempID from SiteInspTemp where SiteID='%@') ",sID,sID,sID];
            
            NSArray * array = [delSQL componentsSeparatedByString:@"|$|"];
            for(int i=array.count-1;i>=0;i--)
            {
                [db ExecSql:[array objectAtIndex:i]];
                [db Setp];
                [db Final];
            }
            
            returnCode = [u GetSiteInspect:sID];
            if(returnCode!=1) return returnCode;
        }
        
    }
    
    [db CloseDB];
    return 1;
}

+(NSMutableArray *)Login:(NSString *)name Password:(NSString *)pwd
{
    NSMutableArray * arr = [[NSMutableArray alloc]init];;
    NSString * sql = [[NSString alloc] initWithFormat:@"select UserId,UserName from Sys_User where Name='%@' and Password='%@' ",name,[Common MD5:pwd]];
    DatabaseHelper *db = [[DatabaseHelper alloc] init];
    //Settings *st =[Settings Instance];
    [db OpenDB:[Settings DatabaseName]];
    sqlite3_stmt * stmt= [db ExecSql:sql];
    if(sqlite3_step(stmt) == SQLITE_ROW)
    {
        [arr addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 0)]];
        [arr addObject:[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 1)]];
    }
    [db Final];
    [db CloseDB];
    return arr;
}

+(NSMutableArray *)GetInspectList1
{
    NSString * sql = [NSString stringWithFormat:@"select LineName,SegmentName,SiteName,InspectWay,InspectDate,Total,InspectActivityID from V_InspectActivity where Finished='1' and Recorder='%@'",[Settings LoginUserId]];
    return [self SqlToArray:sql FieldCount:7];
}

+(NSMutableArray *)GetInspectList2
{
    NSString * sql = [NSString stringWithFormat:@"select LineName,SegmentName,SiteName,InspectWay,InspectDate,Total,InspectActivityID from V_InspectActivity where Finished is null and Recorder='%@'",[Settings LoginUserId]];
    return [self SqlToArray:sql FieldCount:7];
}

+(NSMutableArray *)GetLine
{
    //NSString * sql = [NSString stringWithFormat:@"select * from V_Line where UserId='%@'",[Config GetPlistInfo:@"LoginUserId"]];
    NSString * sql3 = @"";

    NSString * sql2 = [NSString stringWithFormat:@"SELECT LineID FROM UserLine where UserID in (select UserID from Sys_User where Name='%@')" ,[Settings LoginUserName]];
    DatabaseHelper *db = [[DatabaseHelper alloc] init];
    [db OpenDB:[Settings DatabaseName]];
    sqlite3_stmt * stmt= [db ExecSql:sql2];
    while(sqlite3_step(stmt) == SQLITE_ROW)
    {
        sql3 =[ sql3 stringByAppendingString:[NSString stringWithFormat:@"%@','",[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt, 0)]]];
    }
    [db Setp];
    [db Final];

    NSString *where =@"";
    if(![sql3 isEqualToString: @""])
    {
        where = [NSString stringWithFormat:@" where LineID in ('%@') ",sql3];
    }
    
    NSString * sql = [NSString stringWithFormat:@"select * from V_Line %@" ,where];
    return[self SqlToArray:sql FieldCount:4];
}

+(NSMutableArray *)GetSegment
{
    NSString * sql = [NSString stringWithFormat:@"select * from V_Segment where LineID='%@'",[Settings LineID]];
    return [self SqlToArray:sql FieldCount:4];
}

+(NSMutableArray *)GetSite
{
    NSString * sql = [NSString stringWithFormat:@"select * from V_Site where SegmentID='%@'",[Settings SegmentID]];
    return [self SqlToArray:sql FieldCount:6];
}

+(int)BuildCheckData
{
    int returnCode = 1;
    //@try {
    
    NSString * SiteID = [Settings SiteID];
    NSString * InspectDate = [Settings InspectDate];
    NSString * InspectActivityID = [Common GetGuid];
    NSString * InspectWay = [Settings InspectWay];
    NSString * Inspecter =[Settings LoginUserName];
    NSString * Recorder = [Settings LoginUserId];
    NSString * InspectID;
    NSString * SiteInspectID;
    //
    [Settings setInspectActivityID:InspectActivityID];
    //check Site
    DatabaseHelper *db = [[DatabaseHelper alloc] init];
    [db OpenDB:[Settings DatabaseName]];
    NSString *checkSql = [NSString stringWithFormat:@"select count(*) from SiteInspTemp where SiteID='%@'",SiteID];
    sqlite3_stmt * checkStmt= [db ExecSql:checkSql];
    sqlite3_step(checkStmt);
    NSString * checkCount = [NSString stringWithUTF8String:(char*)sqlite3_column_text(checkStmt, 0)];
    [db Final];
    if([checkCount isEqualToString:@"0"])
    {
        [db CloseDB];
        return 41;
    }
    
    
    [db BeginTransaction];
    //
    NSString * sql1 = [NSString stringWithFormat:@"insert into InspectActivity (InspectActivityID,InspectWay,SiteID,Inspecter,InspectDate,Recorder,RecordDate,RealInspectDate) values('%@','%@','%@','%@','%@','%@','%@','%@')",InspectActivityID,InspectWay,SiteID,Inspecter,InspectDate,Recorder,InspectDate,InspectDate];
    [db ExecSql:sql1];
    [db Setp];
    [db Commit];
    [db Final];
    
    NSString * sql2 = [NSString stringWithFormat:@"select * from SiteInspTemp where SiteID='%@'",SiteID];
    sqlite3_stmt * stmt2= [db ExecSql:sql2];
    while(sqlite3_step(stmt2) == SQLITE_ROW)
    {
        InspectID = [Common GetGuid];
        SiteInspectID = [NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt2, 0)]];
        NSString * sql21 = [NSString stringWithFormat:@"insert into Inspect (InspectID,InspectActivityID,SiteInspTempID,Finished,IsCancel,InspectWay,Inspecter,Recorder,InspectDate,RecordDate,SiteID,InspTempID,Name,Optional,InspType,Remarks,Sort,invalid,InspTempWeight,InspCategory) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                            InspectID,InspectActivityID,SiteInspectID,@"0",@"0",InspectWay,Inspecter,Recorder,InspectDate,InspectDate,
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
        [db ExecSql:sql21];
        [db Setp];
        [db Final];
        
        
        
        [db BeginTransaction];
        NSString * sql3 = [NSString stringWithFormat:@"select * from SiteInspItemTemp where Conform<>'1' and  SiteInspTempID='%@'",SiteInspectID];
        sqlite3_stmt * stmt3= [db ExecSql:sql3];
        while(sqlite3_step(stmt3) == SQLITE_ROW)
        {
            NSString * sql31 = [NSString stringWithFormat:@"insert into InspectItem (InspectItemID,InspectID,SiteInspItemTempID,ItemTempID,PItemTempID,Name,Remarks,SpecialItem,Score,Sort,InspTempID,SiteInspTempID,isCancel) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@',0)",[Common GetGuid],InspectID,
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt3, 0)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt3, 1)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt3, 2)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt3, 3)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt3, 4)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt3, 5)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt3, 6)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt3, 7)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt3, 8)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt3, 9)]];
            [db ExecSql:sql31];
            [db Setp];
            
        }
        [db Final];
        sqlite3_finalize(stmt3);
        [db Commit];
        
        [db BeginTransaction];
        NSString * sql4 = [NSString stringWithFormat:@"select * from SiteScoreTemp where SiteInspTempID='%@'",SiteInspectID];
        sqlite3_stmt * stmt4= [db ExecSql:sql4];
        while(sqlite3_step(stmt4) == SQLITE_ROW)
        {
            NSString * sql41 = [NSString stringWithFormat:@"insert into InspectScore (ScoreID,InspectID,SiteScoreTempID,InspScoreTempID,Name,Caption,Score,Sort,InspItemTempID,InspTempID,SiteInspItemTempID,SiteInspTempID,Qualified,Selected) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@',0)",[Common GetGuid],InspectID,
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt4, 0)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt4, 1)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt4, 2)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt4, 3)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt4, 4)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt4, 5)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt4, 6)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt4, 7)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt4, 8)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt4, 9)],
                                [NSString stringWithUTF8String:(char*)sqlite3_column_text(stmt4, 10)]];
            [db ExecSql:sql41];
            [db Setp];
            
        }
        [db Final];
        sqlite3_finalize(stmt4);
        [db Commit];
    }
    sqlite3_finalize(stmt2);
    
    NSString * sql = @"update InspectScore set InspectItemID=(select InspectItemID from InspectItem where InspectItem.InspectID=InspectScore.InspectID and InspectItem.SiteInspItemTempID=InspectScore.SiteInspItemTempID) ";
    [db ExecSql:sql];
    [db Setp];
    [db Final];
    
    [db CloseDB];
    
    //    }
    //    @catch (NSException *exception) {
    //        NSLog(exception.name);
    //        NSLog(exception.reason);
    //    }
    //    @finally {
    //        [db Commit];
    //        [db CloseDB];
    //    }
    
    
    
    return returnCode;
}

+(NSString *)UpdateToService:(NSString *)InspectActivityId
{
    
    NSMutableArray * sqlArray = [[NSMutableArray alloc]init];
    
    NSString * delSQL = @"";
    
    DatabaseHelper *db = [[DatabaseHelper alloc] init];
    [db OpenDB:[Settings DatabaseName]];
    
    NSString * sql = [NSString stringWithFormat:@"select * from InspectActivity where InspectActivityId='%@'",InspectActivityId];
    sqlite3_stmt * stmt= [db ExecSql:sql];
    while (sqlite3_step(stmt) == SQLITE_ROW)
    {
        NSString * updateSQL = @" insert into InspectActivity VALUES(";
        int count = 15;
        for(int i=0;i<count;i++)
        {
            NSString * value = @"0";
            char * cValue = (char*)sqlite3_column_text(stmt, i);
            if(cValue)
                value = [NSString stringWithUTF8String:cValue];
            
            if(i==count-1)
            {
                updateSQL = [updateSQL stringByAppendingFormat:@"'%@'",value];
            }
            else
            {
                updateSQL = [updateSQL stringByAppendingFormat:@"'%@',",value];
            }
        }
        
        updateSQL = [updateSQL stringByAppendingString:@") "];
        [sqlArray addObject:updateSQL];
    }
    delSQL = [delSQL stringByAppendingFormat:@"delete from InspectActivity where InspectActivityId='%@' |$| ",InspectActivityId];
    [db Final];
    sqlite3_finalize(stmt);
    
    //Inspect
    sql = [NSString stringWithFormat:@"select * from Inspect where InspectActivityID='%@'",InspectActivityId];
    stmt= [db ExecSql:sql];
    while (sqlite3_step(stmt) == SQLITE_ROW)
    {
        NSString * updateSQL = @" insert into Inspect VALUES(";
        int count = 23;
        for(int i=0;i<count;i++)
        {
            NSString * value = @"0";
            char * cValue = (char*)sqlite3_column_text(stmt, i);
            if(cValue)
                value = [NSString stringWithUTF8String:cValue];
            
            if(i==count-1)
            {
                updateSQL = [updateSQL stringByAppendingFormat:@"'%@'",value];
            }
            else
            {
                updateSQL = [updateSQL stringByAppendingFormat:@"'%@',",value];
            }
        }
        
        updateSQL = [updateSQL stringByAppendingString:@") "];
        [sqlArray addObject:updateSQL];
    }
    delSQL = [delSQL stringByAppendingFormat:@"delete from Inspect where InspectActivityId='%@' |$| ",InspectActivityId];
    [db Final];
    sqlite3_finalize(stmt);
    
    //InspectItem
    sql = [NSString stringWithFormat:@"select * from InspectItem where InspectID in (select InspectID from Inspect where InspectActivityID='%@')",InspectActivityId];
    stmt= [db ExecSql:sql];
    while (sqlite3_step(stmt) == SQLITE_ROW)
    {
        NSString * updateSQL = @" insert into InspectItem VALUES(";
        int count = 14;
        for(int i=0;i<count;i++)
        {
            NSString * value = @"0";
            char * cValue = (char*)sqlite3_column_text(stmt, i);
            if(cValue)
                value = [NSString stringWithUTF8String:cValue];
            
            if(i==count-1)
            {
                updateSQL = [updateSQL stringByAppendingFormat:@"'%@'",value];
            }
            else
            {
                updateSQL = [updateSQL stringByAppendingFormat:@"'%@',",value];
            }
        }
        
        updateSQL = [updateSQL stringByAppendingString:@") "];
        [sqlArray addObject:updateSQL];
    }
    delSQL = [delSQL stringByAppendingFormat:@"delete from InspectItem where InspectID in (select InspectID from Inspect where InspectActivityID='%@') |$| ",InspectActivityId];
    [db Final];
    sqlite3_finalize(stmt);
    
    //InspectScore
    sql = [NSString stringWithFormat:@"select * from InspectScore where InspectID in (select InspectID from Inspect where InspectActivityID='%@') and inspectitemid is not null",InspectActivityId];
    stmt= [db ExecSql:sql];
    while (sqlite3_step(stmt) == SQLITE_ROW)
    {
        NSString * updateSQL = @" insert into InspectScore VALUES(";
        int count = 15;
        for(int i=0;i<count;i++)
        {
            NSString * value = @"0";
            char * cValue = (char*)sqlite3_column_text(stmt, i);
            if(cValue)
                value = [NSString stringWithUTF8String:cValue];
            
            if(i==count-1)
            {
                updateSQL = [updateSQL stringByAppendingFormat:@"'%@'",value];
            }
            else
            {
                updateSQL = [updateSQL stringByAppendingFormat:@"'%@',",value];
            }
        }
        
        updateSQL = [updateSQL stringByAppendingString:@") "];
        [sqlArray addObject:updateSQL];
    }
    delSQL = [delSQL stringByAppendingFormat:@"delete from InspectScore where InspectID in (select InspectID from Inspect where InspectActivityID='%@') ",InspectActivityId];
    [db Final];
    sqlite3_finalize(stmt);
    //
    NSMutableData *sqlData = [[NSMutableData alloc] init];
    for (int i = 0; i < [sqlArray count]; ++i ){
        NSString *str = [sqlArray objectAtIndex:i];
        NSData *temp = [str dataUsingEncoding:NSUTF8StringEncoding];
        [sqlData appendData:temp];
    }
    //
    //NSData *sqlData = [NSKeyedArchiver archivedDataWithRootObject:sqlArray];
    
    NSString * url = [NSString stringWithFormat:@"IOS/UpdateInspect?ID=%@",InspectActivityId];
    CellService *cs = [[CellService alloc]init];
    NSData * data =[cs CellWeb:url Data:sqlData];
    
    //将NSData转成字符，然后再转成浮点，然后再格式化输出
    NSString *tmp = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    float i = [tmp floatValue];

    NSString *result = [[NSString alloc] initWithFormat:@"%.2f",i];
    //NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    
    NSArray * array = [delSQL componentsSeparatedByString:@"|$|"];
    for(int i=array.count-1;i>=0;i--)
    {
        [db ExecSql:[array objectAtIndex:i]];
        [db Setp];
        [db Final];
    }
    
    [db CloseDB];
    
    return result;
}





@end
