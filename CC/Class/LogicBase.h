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
#import "Update.h"

@interface LogicBase : NSObject

+(NSMutableArray *)SqlToArray:(NSString *)sql FieldCount:(int) count;
+(void)SetArrayLevel3:(NSMutableArray *)arr Value:(NSString *)value Level1:(int)l1 Level2:(int)l2 Level3:(int)l3;
//
+(int)UpdateByService;
//
+(NSMutableArray *)Login:(NSString *)name Password:(NSString *)pwd;
//
+(NSMutableArray *)GetInspectList1;
+(NSMutableArray *)GetInspectList2;
//
+(NSMutableArray *)GetLine;
+(NSMutableArray *)GetSegment;
+(NSMutableArray *)GetSite;
//
+(int)BuildCheckData;
//
+(NSString *)UpdateToService:(NSString *)InspectActivityId;
@end
