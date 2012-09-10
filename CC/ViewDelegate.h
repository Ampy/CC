//
//  ViewDelegate.h
//  WMSG
//
//  Created by fy ren on 12-9-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewDelegate <NSObject>
-(void)passValue:(NSString *)value arrayIndex:(int) index;
@end


