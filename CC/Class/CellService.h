//
//  CellService.h
//  文明施工
//
//  Created by fy ren on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@interface CellService : NSObject

-(NSString *) CellWeb:(NSString *)url;
-(NSData *) CellWeb:(NSString *)url Data:(NSData *) postData;
-(NSData *) CellWebData:(NSString *)url;
-(NSString *) CheckLogin:(NSString *)name Password:(NSString *)pwd;

@end
