//
//  InputViewController.h
//  WMSG
//
//  Created by fy ren on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "ViewDelegate.h"
#import "InputSubView.h"
#import "InspectViewController.h"

@interface InputViewController : UIViewController<ViewDelegate>
{
    NSMutableArray *listArr;
    NSString *checkType;
    NSString *checkTypeName;
    InputSubView *subView;
    bool IsOpenSubView;
    dispatch_queue_t queue;
}
@property (nonatomic,retain) NSString *checkType;
@property (nonatomic,retain) NSString *checkTypeName;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *MaskView;
@property (retain, nonatomic) IBOutlet UIWebView *WaitWebView;

@end

