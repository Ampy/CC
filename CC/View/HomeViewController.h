//
//  HomeViewController.h
//  WMSG
//
//  Created by fy ren on 12-9-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManageViewController.h"
#import "InputViewController.h"
#import "LoginViewController.h"

@interface HomeViewController : UIViewController
{
    UIView *bgView;
    UIWebView * webView;
}

- (IBAction)clickButton:(id)sender;
- (IBAction)Logout:(id)sender;
- (IBAction)Update:(id)sender;


@end
