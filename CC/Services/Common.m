//
//  Common.m
//  CC
//
//  Created by fy ren on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "Common.h"
#import <SystemConfiguration/SystemConfiguration.h> 

@implementation Common
+(NSString *) CStringToNSString:(char *) string
{
    return[[NSString alloc] initWithCString:string encoding:NSUTF8StringEncoding];
}

+(NSString *)MD5:(NSString *)value
{
	const char *cStr = [value UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}

+(NSString *) GetGuid
{
    //CFUUIDRef uuidObj = CFUUIDCreate(nil);
    //CFStringRef uuid = CFUUIDCreateString(nil, uuidObj);
    //NSString *uuidString = (__bridge NSString *)uuid;
    //CFRelease(uuidObj);
    //return uuidString;
    
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

+(int) CheckNetworkStatus
{
  
    Reachability *r = [Reachability reachabilityWithHostname:[Settings ServiceUrl]];

    if ([r currentReachabilityStatus]==NotReachable)
    {
        NSLog(@"%@ 网络无法到达",[Settings ServiceUrl]);
        return 21;
    }
    else 
    {	
        return 1;
    }
}

+ (int)networkState
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // 以下objc相关函数、类型需要添加System Configuration 框架
    // 用0.0.0.0来判断本机网络状态
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr*)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability,&flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return -1;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    return (isReachable && !needsConnection) ? 1 : 0;
}

+(bool)ExceptionHandler:(int)returnCode
{
    if(returnCode==1)
    {
        return NO;
    }
    else 
    {
        Plist *plist = [[Plist alloc]initWithFileName:@"config"];
        [self Alert:[plist GetValueByPath:[NSString stringWithFormat:@"%d",returnCode]]];
        //[self Alert:[Config GetPlistInfo:[NSString stringWithFormat:@"%d",returnCode]]];
        return YES;
    }
}

+(void)Alert:(NSString *) message
{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
    [alert show];
}

@end
