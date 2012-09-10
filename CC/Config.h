//
//  Config.h
//  WMSG
//
//  Created by fy ren on 12-9-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject

+(NSMutableDictionary *)GetPlist;
+(NSString *)GetPlistInfo:(NSString*)PName;
+(void) SetPlistInfo:(NSString *)PName Value:(NSString *)PValue;

@end
