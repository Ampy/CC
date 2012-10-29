//
//  LoginViewController.h
//  WMSG
//
//  Created by fy ren on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogicBase.h"
#import "HomeViewController.h"

@interface LoginViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *name;
@property (retain, nonatomic) IBOutlet UITextField *password;
@property (retain, nonatomic) IBOutlet UISwitch *remember;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)textFieldDidBeginEditing:(id)sender;

@end
