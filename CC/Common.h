//
//  Common.h
//  CC
//
//  Created by fy ren on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Common : NSObject
//Char*转NSString
+(NSString *) CStringToNSString:(char *) string;
+(NSString *)MD5:(NSString *)value;



@end
