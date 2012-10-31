//
//  Settings.m
//  CC
//
//  Created by fy ren on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "Settings.h"

@implementation Settings


NSString *fileName=@"config";

+(NSString *) ServiceUrl
{
    return [Plist GetValue:fileName Path:@"ServiceUrl"];
}
+(NSString *) DatabaseName
{
    return [Plist GetValue:fileName Path:@"DataBaseName"];
}

+(NSString *) IsInit
{
    return [Plist GetValue:fileName Path:@"IsInit"];
}
+(NSString *) LineID
{
    return [Plist GetValue:fileName Path:@"LineID"];
}
+(NSString *) SegmentID
{
    return [Plist GetValue:fileName Path:@"SegmentID"];
}
+(NSString *) SiteID
{
    return [Plist GetValue:fileName Path:@"SiteID"];
}
+(NSString *) InspectWay
{
    return [Plist GetValue:fileName Path:@"InspectWay"];
}
+(NSString *) InspectDate
{
    return [Plist GetValue:fileName Path:@"InspectDate"];
}
+(NSString *) LoginUserName
{
    return [Plist GetValue:fileName Path:@"LoginUserName"];
}
+(NSString *) LoginUserId
{
    return [Plist GetValue:fileName Path:@"LoginUserId"];
}
+(NSString *) InspectActivityID
{
    return [Plist GetValue:fileName Path:@"InspectActivityID"];
}

+(void)setLineID:(NSString *)lineID
{
    [Plist SetValue:fileName SectionPath:@"LineID" SectionValue:lineID];
}

+(void)setSegmentID:(NSString *)segmentID
{
    [Plist SetValue:fileName SectionPath:@"SegmentID" SectionValue:segmentID];
}

+(void)setSiteID:(NSString *)siteID
{
    [Plist SetValue:fileName SectionPath:@"SiteID" SectionValue:siteID];
}

+(void)setIsInit:(NSString *)isInit
{
    [Plist SetValue:fileName SectionPath:@"IsInit" SectionValue:isInit];
}

+(void)setInspectActivityID:(NSString *)inspectActivityID;
{
    [Plist SetValue:fileName SectionPath:@"InspectActivityID" SectionValue:inspectActivityID];  
}

+(void)setLoginUserName:(NSString *)loginUserName
{
    [Plist SetValue:fileName SectionPath:@"LoginUserName" SectionValue:loginUserName];     
}

+(void)setInspectWay:(NSString *)inspectWay
{
    [Plist SetValue:fileName SectionPath:@"InspectWay" SectionValue:inspectWay];    
}
+(void)setInspectDate:(NSString *)inspectDate
{
    [Plist SetValue:fileName SectionPath:@"InspectDate" SectionValue:inspectDate];    
}

+(void)setLoginUserId:(NSString *)loginUserId
{
    [Plist SetValue:fileName SectionPath:@"LoginUserId" SectionValue:loginUserId];     
}


@end
