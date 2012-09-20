//
//  InspectService.h
//  Construction
//
//  Created by  rtsafe02 on 12-9-5.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseHelper.h"
#import "../Models/InspectModel.h"
#import "../Models/InspectItemModel.h"
#import "../Models/ScoreItemModel.h"
#import "Settings.h"

@interface InspectService : NSObject
{
    DatabaseHelper *databaseHelper;
    NSString * dbName ;
}

//根据InspectActivityID获取相关Inspect信息
-(NSMutableArray *)GetInspects:(NSString *)activityId;

//根据InspectID和ParentItemID获取Parent下的所有第一级子节点
-(NSMutableArray *)GetInspectItems:(NSString *)inspectId ParentItemId:(NSString *)parentItemId;

-(NSMutableArray *)GetInspectScoreItems:(NSString *) inspectItemId;
-(int) GetInspectSocreItemsCount:(NSString *)inspectItemId;
-(void) SelectInspectScoreItem:(NSString *)inspectScoreId value:(int)value;
-(void) SetInspectItemCancel:(NSString *)inspectid ItemId:(NSString *)itemId value:(int)value Level:(int)level;

-(int) InspectItemScoreComplete:(NSString *) itemId;

-(BOOL) CanCommitInspectActivity:(NSString *)acitvityId;
-(void) InspectActivityComplete:(NSString *)acitvityId;
@end
