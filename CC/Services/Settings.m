//
//  Settings.m
//  CC
//
//  Created by fy ren on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "Settings.h"

@implementation Settings


//NSString *fileName ;

+(NSString *) GetFileFullPath
{
    NSArray *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docPath = [ doc objectAtIndex:0 ]; // 字典集合。
    
    return [docPath stringByAppendingPathComponent:@"config.plist"];
}

+(NSString *) ServiceUrl
{
    return [Plist GetValue:[self GetFileFullPath] Path:@"ServiceUrl"];
}
+(NSString *) DatabaseName
{
    return [Plist GetValue:[self GetFileFullPath] Path:@"DataBaseName"];
}

+(NSString *) IsInit
{
    return [Plist GetValue:[self GetFileFullPath] Path:@"IsInit"];
}
+(NSString *) LineID
{
    return [Plist GetValue:[self GetFileFullPath] Path:@"LineID"];
}
+(NSString *) SegmentID
{
    return [Plist GetValue:[self GetFileFullPath] Path:@"SegmentID"];
}
+(NSString *) SiteID
{
    return [Plist GetValue:[self GetFileFullPath] Path:@"SiteID"];
}
+(NSString *) InspectWay
{
    return [Plist GetValue:[self GetFileFullPath] Path:@"InspectWay"];
}
+(NSString *) InspectDate
{
    return [Plist GetValue:[self GetFileFullPath] Path:@"InspectDate"];
}
+(NSString *) LoginUserName
{
    return [Plist GetValue:[self GetFileFullPath] Path:@"LoginUserName"];
}
+(NSString *) LoginUser
{
    return [Plist GetValue:[self GetFileFullPath] Path:@"LoginUser"];
}
+(NSString *) LoginUserId
{
    return [Plist GetValue:[self GetFileFullPath] Path:@"LoginUserId"];
}
+(NSString *) InspectActivityID
{
    return [Plist GetValue:[self GetFileFullPath] Path:@"InspectActivityID"];
}

+(void)setLineID:(NSString *)lineID
{
    [Plist SetValue:[self GetFileFullPath] SectionPath:@"LineID" SectionValue:lineID];
}

+(void)setSegmentID:(NSString *)segmentID
{
    [Plist SetValue:[self GetFileFullPath] SectionPath:@"SegmentID" SectionValue:segmentID];
}

+(void)setSiteID:(NSString *)siteID
{
    [Plist SetValue:[self GetFileFullPath] SectionPath:@"SiteID" SectionValue:siteID];
}

+(void)setIsInit:(NSString *)isInit
{
    [Plist SetValue:[self GetFileFullPath] SectionPath:@"IsInit" SectionValue:isInit];
}

+(void)setInspectActivityID:(NSString *)inspectActivityID;
{
    [Plist SetValue:[self GetFileFullPath] SectionPath:@"InspectActivityID" SectionValue:inspectActivityID];  
}

+(void)setLoginUserName:(NSString *)loginUserName
{
    [Plist SetValue:[self GetFileFullPath] SectionPath:@"LoginUserName" SectionValue:loginUserName];     
}

+(void)setLoginUser:(NSString *)loginUser
{
    [Plist SetValue:[self GetFileFullPath] SectionPath:@"LoginUser" SectionValue:loginUser];
}

+(void)setInspectWay:(NSString *)inspectWay
{
    [Plist SetValue:[self GetFileFullPath] SectionPath:@"InspectWay" SectionValue:inspectWay];    
}
+(void)setInspectDate:(NSString *)inspectDate
{
    [Plist SetValue:[self GetFileFullPath] SectionPath:@"InspectDate" SectionValue:inspectDate];    
}

+(void)setLoginUserId:(NSString *)loginUserId
{
    [Plist SetValue:[self GetFileFullPath] SectionPath:@"LoginUserId" SectionValue:loginUserId];     
}

+(void)setServiceUrl:(NSString *)serviceUrl
{
    [Plist SetValue:[self GetFileFullPath] SectionPath:@"ServiceUrl" SectionValue:serviceUrl]; 
}
@end
