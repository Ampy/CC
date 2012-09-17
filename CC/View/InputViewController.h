//
//  InputViewController.h
//  WMSG
//
//  Created by fy ren on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "Config.h"
#import "ViewDelegate.h"
#import "InputSubView.h"
#import "InspectViewController.h"

@interface InputViewController : UIViewController<ViewDelegate>
{
    NSMutableArray *listArr;
    NSString *checkType;
    InputSubView *subView;
    bool IsOpenSubView;
}
@property (nonatomic,retain) NSString *checkType;

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
