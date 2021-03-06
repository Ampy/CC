//
//  Update.h
//  文明施工
//
//  Created by fy ren on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseHelper.h"
#import "CellService.h"
#import "Settings.h"

@interface Update : NSObject
-(int)GetTableStruct:(NSString *)tableName;
-(int)GetTableStructs:(NSArray *)tableNames;
-(int)GetTableData:(NSString *)tableName;
-(int)UpdateAll:(NSArray *)tableNames;

-(int)GetSiteInspect:(NSString *)sID;
-(int)GetAccord;
@end
