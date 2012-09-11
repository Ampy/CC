//
//  LogicBase.h
//  CC
//
//  Created by fy ren on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseHelper.h"
#import "Settings.h"
#import "Common.h"

@interface LogicBase : NSObject
+(NSMutableArray *)Login:(NSString *)name Password:(NSString *)pwd;
+(NSMutableArray *)SqlToArray:(NSString *)sql FieldCount:(int) count;
+(NSMutableArray *)GetInspectList1;
+(NSMutableArray *)GetInspectList2;
@end
