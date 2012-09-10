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
            globalSettings.DatabaseName = [NSString stringWithFormat:@"%@", [dictionary objectForKey: @"DatabaseName"]];
            return  globalSettings;
        }
    }
    return nil;
}

+Add:(NSString *)Name KeyName:(NSString *)Key
{
    
}

@end
