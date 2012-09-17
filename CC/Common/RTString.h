//
//  RTString.h
//  CivilizedConstruction
//
//  Created by  rtsafe02 on 12-8-23.
//  Copyright (c) 2012年  rtsafe02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTString : NSObject
//Char*转NSString
+(NSString *) CStringToNSString:(char *) string;
+(NSString *)MD5:(NSString *)value;
@end
