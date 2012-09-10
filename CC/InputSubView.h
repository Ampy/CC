//
//  InputSubView.h
//  WMSG
//
//  Created by fy ren on 12-9-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewDelegate.h"

@interface InputSubView : UIView
{
    NSObject<ViewDelegate> * delegate;
    int index;
}

@property(nonatomic, retain) NSObject<ViewDelegate> * delegate;
@property int index;
@end
