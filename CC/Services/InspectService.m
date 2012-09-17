//
//  InspectService.m
//  Construction
//
//  Created by  rtsafe02 on 12-9-5.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "InspectService.h"

@implementation InspectService



-(id) init
{
    self=[super init];
    if(self)
    {
        databaseHelper = [[DatabaseHelper alloc] init];
    }
    dbName = [NSString stringWithString:[Settings Instance].DatabaseName];
    return self;
}

-(NSMutableArray *)GetInspects:(NSString *)activityId
{
    [databaseHelper OpenDB:dbName];
    NSString * sql = [[NSString alloc] initWithFormat:@"SELECT InspectActivityId,InspectCode,Name,InspectId,InspTempId FROM INSPECT WHERE InspectActivityId='%@'",activityId];
    sqlite3_stmt * statement = [databaseHelper ExecSql:sql];
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:5];
    InspectModel *model;
    while (sqlite3_step(statement)==SQLITE_ROW) {
        model=[[InspectModel alloc] init];
        model.InspectActivityID=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
        //model.InspectCode =[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
        model.Name = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
        model.InspectId= [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
        model.InspTempID= [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 4) encoding:NSUTF8StringEncoding];
        [list addObject:model];
    }
    
    sqlite3_finalize(statement);
    [databaseHelper CloseDB];
    return list;
}

-(NSMutableArray *)GetInspectItems:(NSString *)inspectId ParentItemId:(NSString *)parentItemId
{
    [databaseHelper OpenDB:dbName];
    NSString * sql = [[NSString alloc] initWithFormat:@"SELECT InspectItemID,SiteInspItemTempID,ItemTempID,PItemTempID,Name,Remarks,SpecialItem,Score,Sort,InspTempID,SiteInspTempID,InspectID,Total,IsCancel FROM INSPECTITEM WHERE InspectId='%@' AND PItemTempID = '%@'",inspectId,parentItemId];
    sqlite3_stmt * statement = [databaseHelper ExecSql:sql];
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:5];
    InspectItemModel *model;
    while (sqlite3_step(statement)==SQLITE_ROW) {
        model=[[InspectItemModel alloc] init];
        model.InspectItemID=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
        model.SiteInspItemTempID =[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
        model.ItemTempID = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
        model.PItemTempID = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
        model.Name = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 4) encoding:NSUTF8StringEncoding];
        if(sqlite3_column_text(statement, 5))
        {
        model.Remarks = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 5) encoding:NSUTF8StringEncoding];
        }
        else
        {
            model.Remarks=@"";
        }
        model.SpecialItem = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 6) encoding:NSUTF8StringEncoding];
        model.Score = [[NSNumber alloc] initWithFloat:sqlite3_column_double(statement, 7)];
        model.Sort = [[NSNumber alloc] initWithInteger:sqlite3_column_int(statement, 8)];
        model.InspTempID = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 9) encoding:NSUTF8StringEncoding];
        model.SiteInspTempID = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 10) encoding:NSUTF8StringEncoding];
        model.InspectID = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 11) encoding:NSUTF8StringEncoding];
        model.Total = [[NSNumber alloc] initWithFloat:sqlite3_column_double(statement, 12)];
        model.IsCancel = [[NSNumber alloc] initWithFloat:sqlite3_column_double(statement, 13)];
        
        [list addObject:model];
    }
    
    sqlite3_finalize(statement);
    [databaseHelper CloseDB];
    return list;
}

-(NSMutableArray *)GetInspectScoreItems:(NSString *) inspectItemId
{
    [databaseHelper OpenDB:dbName];
    NSString * sql = [[NSString alloc] initWithFormat:@"SELECT ScoreID,SiteScoreTempID,InspScoreTempID,Name,Caption,Score,Sort,InspItemTempID,InspTempID,SiteInspItemTempID,SiteInspTempID,InspectItemID,InspectID,Selected,Qualified FROM INSPECTSCORE WHERE InspectItemId='%@' ORDER BY Sort",inspectItemId];
    sqlite3_stmt * statement = [databaseHelper ExecSql:sql];
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:5];
    ScoreItemModel *model;
    while (sqlite3_step(statement)==SQLITE_ROW) {
        model=[[ScoreItemModel alloc] init];
        model.ScoreID=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
        model.SiteScoreTempID =[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
        model.InspScoreTempID = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
        model.Name = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
        model.Caption = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 4) encoding:NSUTF8StringEncoding];
        model.Score = [[NSNumber alloc] initWithFloat:sqlite3_column_double(statement, 5)];
        model.Sort = [[NSNumber alloc] initWithFloat:sqlite3_column_double(statement, 6)];
        model.InspItemTempID = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 7) encoding:NSUTF8StringEncoding];
        model.InspTempID = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 8) encoding:NSUTF8StringEncoding];
        model.SiteInspItemTempID = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 9) encoding:NSUTF8StringEncoding];
        model.SiteInspTempID = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 10) encoding:NSUTF8StringEncoding];
        model.InspectItemID = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 11) encoding:NSUTF8StringEncoding];
        model.InspectID = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 12) encoding:NSUTF8StringEncoding];
        model.Selected = [[NSNumber alloc] initWithFloat:sqlite3_column_double(statement, 13)];
        model.Qualified = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 14) encoding:NSUTF8StringEncoding];
        [list addObject:model];
    }
    
    sqlite3_finalize(statement);
    [databaseHelper CloseDB];
    return list;
}

-(int) GetInspectSocreItemsCount:(NSString *)inspectItemId{
    [databaseHelper OpenDB:dbName];
    NSString * sql = [[NSString alloc] initWithFormat:@"SELECT count(1) FROM INSPECTSCORE WHERE InspectItemId='%@'",inspectItemId];
    sqlite3_stmt * statement = [databaseHelper ExecSql:sql];
    int count = 0;
    if (sqlite3_step(statement)==SQLITE_ROW) {
         count = sqlite3_column_int(statement, 0);
    }
    
    sqlite3_finalize(statement);
    [databaseHelper CloseDB];
    return count;
}

-(void) SelectInspectScoreItem:(NSString *)inspectScoreId value:(int)value
{
    [databaseHelper OpenDB:dbName];
    NSString * sql = [[NSString alloc] initWithFormat:@"SELECT InspectItemId FROM INSPECTSCORE WHERE ScoreID='%@'",inspectScoreId];
    sqlite3_stmt * statement = [databaseHelper ExecSql:sql];
    NSString *inspectItemId;
    if (sqlite3_step(statement)==SQLITE_ROW)
    {
        inspectItemId=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
        
        NSString * sql2 = [[NSString alloc] initWithFormat:@"UPDATE INSPECTSCORE SET SELECTED=0 WHERE InspectItemId='%@'", inspectItemId];
        //statement = [databaseHelper ExecSql:sql2];
        [databaseHelper ExecuteNonQuery:sql2];
        //if(sqlite3_step(statement)==SQLITE_ROW)
        //{
            NSString * sql3 = [[NSString alloc] initWithFormat:@"UPDATE INSPECTSCORE SET SELECTED=%d WHERE ScoreID='%@'",value,inspectScoreId];
            //statement = [databaseHelper ExecSql:sql3];
        [databaseHelper ExecuteNonQuery:sql3];
        //}
    }
    
    sqlite3_finalize(statement);
    [databaseHelper CloseDB];
        
}

-(void) SetInspectItemCancel:(NSString *)inspectid ItemId:(NSString *)itemId value:(int)value Level:(int)level;
{
    [databaseHelper OpenDB:dbName];
    [self SetChildItemCancel:inspectid ItemId:itemId value:value Level:level];
    [self SetParentItemCancel:inspectid ItemId:itemId value:value Level:level];
    [databaseHelper CloseDB];
}

-(void) SetParentItemCancel:(NSString *)inspectid ItemId:(NSString *)itemId value:(int)value Level:(int)level
{
    if(value==1) return;
    
    if(level==1) return;
    
    if(level==2)
    {
        NSString * updatesql1=[[NSString alloc] initWithFormat:@"update inspectItem set isCancel=%d  where ItemTempId In(select PItemTempId from InspectItem where InspectItemId='%@' and InspectId='%@') and InspectId='%@'",value,itemId,inspectid,inspectid];
        [databaseHelper ExecuteNonQuery:updatesql1];
    }
    
    if(level==3)
    {
        NSString * updatesql1=[[NSString alloc] initWithFormat:@"update inspectItem set isCancel=%d  where ItemTempId In(select PItemTempId from InspectItem where InspectItemId='%@' and InspectId='%@') and InspectId='%@'",value,itemId,inspectid,inspectid];
        [databaseHelper ExecuteNonQuery:updatesql1];
        
        NSString * updatesql2=[[NSString alloc] initWithFormat:@"update inspectItem set isCancel=%d where ItemTempId in (select PItemTempId From InspectItem where ItemTempId In(select PItemTempId from InspectItem where InspectItemId='%@' and InspectId='%@') and InspectId='%@')  and InspectId='%@'",value,itemId,inspectid,inspectid,inspectid];
        [databaseHelper ExecuteNonQuery:updatesql2];
    }
}

-(void) SetChildItemCancel:(NSString *)inspectid ItemId:(NSString *)itemId value:(int)value Level:(int)level;
{

    if(level==1)
    {
        NSString * updatesql1=[[NSString alloc] initWithFormat:@"update inspectItem set isCancel=%d  where InspectItemId='%@'",value,itemId];
        [databaseHelper ExecuteNonQuery:updatesql1];
        
        
        NSString * updatesql2=[[NSString alloc] initWithFormat:@"update inspectItem set isCancel=%d  where PitemTempId in(select ItemTempId from InspectItem where inspectid='%@' and inspectitemid='%@') and inspectid='%@'",value,inspectid,itemId,inspectid];
        [databaseHelper ExecuteNonQuery:updatesql2];
        
        NSString * updatesql3=[[NSString alloc] initWithFormat:@"update inspectItem set isCancel=%d where PItemTempId in( select ItemTempId from InspectItem where PitemTempId in(select ItemTempId from InspectItem where inspectid='%@' and inspectitemid='%@') and inspectid='%@') and inspectid='%@'",value,inspectid,itemId,inspectid,inspectid];
        [databaseHelper ExecuteNonQuery:updatesql3];
        
    }
    if(level==2)
    {
        NSString * updatesql1=[[NSString alloc] initWithFormat:@"update inspectItem set isCancel=%d  where InspectItemId='%@'",value,itemId];
        [databaseHelper ExecuteNonQuery:updatesql1];
        
        
        NSString * updatesql2=[[NSString alloc] initWithFormat:@"update inspectItem set isCancel=%d  where PitemTempId in(select ItemTempId from InspectItem where inspectid='%@' and inspectitemid='%@') and inspectid='%@'",value,inspectid,itemId,inspectid];
        [databaseHelper ExecuteNonQuery:updatesql2];
    }
    
    if(level==3)
    {
        NSString * updatesql1=[[NSString alloc] initWithFormat:@"update inspectItem set isCancel=%d  where InspectItemId='%@'",value,itemId];
        [databaseHelper ExecuteNonQuery:updatesql1];
    }
    
}

-(void) InspectScore:(NSString *) inspectId
{
    //计算第3层
    
    //找出勾选的项
    NSString * selectScoreSql=[[NSString alloc] initWithFormat:@"SELECT InspectItemId,Score FROM InspectScore WHERE InspectId='%@' AND Selected=1",inspectId];
    sqlite3_stmt * statement = [databaseHelper ExecSql:selectScoreSql];
    
    NSMutableArray *ScoreItems=[NSMutableArray arrayWithCapacity:0];
    ScoreItemModel *scoreModel;
    while (sqlite3_step(statement)==SQLITE_ROW) {
        scoreModel=[[ScoreItemModel alloc] init];
        scoreModel.InspectItemID=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];;
        scoreModel.Score=[[NSNumber alloc] initWithFloat:sqlite3_column_double(statement, 1)];;
        [ScoreItems addObject:scoreModel];
    }
    sqlite3_finalize(statement);

    //更新第3层的Total
    
    //--update inspectitem set isCancel=(select abs(sum(selected)-1) from inspectscore where --inspectscore.inspectitemid=inspectitem.inspectitemid)
    //--,Total=Score*(select score from inspectscore where inspectscore.inspectitemid=inspectitem.inspectitemid and selected=1)
    //--where inspectid=x'CAF043EB02F36D488FF6867FBCFE01F0';
    
    //--update inspectitem set total=0 where  inspectid=x'CAF043EB02F36D488FF6867FBCFE01F0' and iscancel=1
    
    for(ScoreItemModel *sm in ScoreItems)
    {
    NSString * updateSql3=[[NSString alloc] initWithFormat:@"UPDATE InspectItem SET Total=Score * %f WHERE InspectItemId='%@'",sm.Score.floatValue, inspectId];
        [databaseHelper ExecuteNonQuery:updateSql3];
    }
    //计算第2层
    
    //找出第二层所有项
    NSString * selectsql2=[[NSString alloc] initWithFormat:@"SELECT InspectItemId,PItemTempId FROM InspectItem where ItemTempId in (select PItemTempId From InspectItem where ItemTempId In(select PItemTempId from InspectItem where InspectItemId in (select InspectItemId from InspectScore where inspectid='%@' group by InspectItemId) and InspectId='%@') and InspectId='%@')  and InspectId='%@'",inspectId,inspectId,inspectId,inspectId];
    sqlite3_stmt * statement2 = [databaseHelper ExecSql:selectsql2];
    
    //NSMutableArray *Level2Items=[NSMutableArray arrayWithCapacity:0];
    InspectItemModel *level2Model;
    while (sqlite3_step(statement2)==SQLITE_ROW) {
        level2Model = [[InspectItemModel alloc] init];
//        level2Model.InspectItemID=;
//        level2Model.PItemTempID=;
    }
    //计算第1层
}
@end
