//
//  RTString.m
//  CivilizedConstruction
//
//  Created by  rtsafe02 on 12-8-23.
//  Copyright (c) 2012年  rtsafe02. All rights reserved.
//

#import "RTString.h"


@implementation RTString
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

@end
