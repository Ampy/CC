//
//  Settings.h
//  CC
//
//  Created by fy ren on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"

@interface Settings : NSObject
@property (nonatomic, retain) NSString* ServiceUrl;
@property (nonatomic, strong) NSString* DatabaseName;
@property (nonatomic, strong) NSString* LoginName;
+(Settings *)Instance;
+Add:(NSString *)Name KeyName:(NSString *)Key;
@end
