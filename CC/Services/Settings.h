//
//  Settings.h
//  CC
//
//  Created by fy ren on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Plist.h"

@interface Settings : NSObject
//@property (nonatomic, retain) NSString* ServiceUrl;
//@property (nonatomic, retain) NSString* DatabaseName;
//@property (nonatomic, retain) NSString* LoginName;
//@property (nonatomic, retain) NSString* IsInit;
//@property (nonatomic, retain) NSString* LineID;
//@property (nonatomic, retain) NSString* SegmentID;
//@property (nonatomic, retain) NSString* SiteID;
//@property (nonatomic, retain) NSString* InspectWay;
//@property (nonatomic, retain) NSString* InspectDate;
//@property (nonatomic, retain) NSString* LoginUserName;
//@property (nonatomic, retain) NSString* LoginUserId;
//@property (nonatomic, retain) NSString* InspectActivityID;

@property (nonatomic, retain) NSMutableDictionary * dic;

+(NSString *) ServiceUrl;
+(NSString *) DatabaseName;
+(NSString *) IsInit;
+(NSString *) LineID;
+(NSString *) SegmentID;
+(NSString *) SiteID;
+(NSString *) InspectWay;
+(NSString *) InspectDate;
+(NSString *) LoginUserName;
+(NSString *) LoginUserId;
+(NSString *) InspectActivityID;

+(void)setLineID:(NSString *)lineID;
+(void)setSegmentID:(NSString *)segmentID;
+(void)setSiteID:(NSString *)siteID;
+(void)setIsInit:(NSString *)isInit;
+(void)setInspectActivityID:(NSString *)inspectActivityID;
+(void)setLoginUserName:(NSString *)loginUserName;
+(void)setLoginUserId:(NSString *)loginUserId;
+(void)setInspectWay:(NSString *)inspectWay;
+(void)setInspectDate:(NSString *)inspectDate;

@end
