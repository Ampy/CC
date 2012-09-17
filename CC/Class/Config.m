//
//  Config.m
//  WMSG
//
//  Created by fy ren on 12-9-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Config.h"

@implementation Config

+(NSMutableDictionary *)GetPlist
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return dic;
}

+(NSString *)GetPlistInfo:(NSString*)PName
{
    NSString * value = [[self GetPlist] objectForKey:PName];
    return value;
}

+(void) SetPlistInfo:(NSString *)PName Value:(NSString *)PValue
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    [dic setObject:PValue forKey:PName];
    [dic writeToFile:plistPath atomically:YES];
}


@end
