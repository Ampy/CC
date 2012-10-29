//
//  Common.h
//  CC
//
//  Created by fy ren on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "Settings.h"
#import <CommonCrypto/CommonDigest.h>

@interface Common : NSObject
//Char*转NSString
+(NSString *) CStringToNSString:(char *) string;
+(NSString *)MD5:(NSString *)value;
+(int) CheckNetworkStatus;
+(NSString *) GetGuid;
+(void)Alert:(NSString *) message;
+(bool)ExceptionHandler:(int)returnCode;
@end
