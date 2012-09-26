//
//  ManageViewController.h
//  WMSG
//
//  Created by fy ren on 12-9-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface ManageViewController : UIViewController
{
    NSMutableArray *lists;
    NSMutableArray *lists2;
    int submitCount;
    UIButton *upButton;
    UIView *bgView;
    UIWebView * webView;
}
@property (strong, nonatomic) IBOutlet UITableView *updateTableView;


@end
