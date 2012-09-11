		//
//  Settings.m
//  CC
//
//  Created by fy ren on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "Settings.h"

static Settings *globalSettings = nil;
@implementation Settings
@synthesize ServiceUrl;
@synthesize DatabaseName;
@synthesize LoginName;
@synthesize dic;

+(Settings *)Instance{
    @synchronized(self){
        if(globalSettings == nil){
            globalSettings=[[self alloc] init];
        }
    }
    return globalSettings;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (globalSettings == nil) {
            globalSettings = [super allocWithZone:zone];
            
            //读取配置表Settings.plist
            NSDictionary *dictionary = [Config GetPlist];
            globalSettings.ServiceUrl = [NSString stringWithFormat:@"%@", [dictionary objectForKey: @"ServiceUrl"]];               
            globalSettings.DatabaseName = [NSString stringWithFormat:@"%@", [dictionary objectForKey: @"DataBaseName"]];
            return  globalSettings;
        }
    }
    return nil;
}

+(void)AddLoginName:(NSString *)Name
{
    globalSettings.LoginName = Name;
}

+(void)Add:(NSString *)Name KeyName:(NSString *)Key
{
    [globalSettings.dic setObject:Name forKey:Key];
}

+(NSString *)GetNameByKey:(NSString *)Key
{
    return [globalSettings.dic objectForKey:Key];
}

@end
