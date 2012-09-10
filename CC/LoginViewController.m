//
//  LoginViewController.m
//  WMSG
//
//  Created by fy ren on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize remember;
@synthesize name;
@synthesize password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed: @"login.jpg"]]];
    
    UIButton *outButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [outButton setFrame:CGRectMake(580, 474, 98, 32)];
    [outButton setBackgroundImage:[UIImage imageNamed:@"login_sumit.png"] forState:UIControlStateNormal];
    [self.view addSubview:outButton];
    [outButton addTarget:self  action:@selector(UserLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.userInteractionEnabled = YES;
    
    NSString * isRemember = [Config GetPlistInfo:@"LoginIsRemember"];
    if([isRemember isEqualToString: @"T"])
    {
        [remember setOn:true animated:NO];
        name.text = [Config GetPlistInfo:@"LoginName"];
        password.text = [Config GetPlistInfo:@"LoginPassword"];
    }
    else 
    {
        [remember setOn:false animated:NO];
    }
}

- (void)viewDidUnload
{
    [self setName:nil];
    [self setPassword:nil];
    [self setRemember:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)UserLogin:(id)sender {
    if(remember.isOn)
    {
        [Config SetPlistInfo:@"LoginName" Value:name.text];
        [Config SetPlistInfo:@"LoginPassword" Value:password.text];
        [Config SetPlistInfo:@"LoginIsRemember" Value:@"T"];
    }
    else
    {
        [Config SetPlistInfo:@"LoginIsRemember" Value:@"F"];
    }
    
    NSString *loginName = [NSString stringWithString:[LogicBase Login:name.text Password:password.text]];
    
    if([loginName isEqualToString:@"F"])
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"登陆提示" message:@"用户名或密码错误！" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alert show];
    }
    else 
    {
        [Config SetPlistInfo:@"LoginName" Value:loginName];
        HomeViewController *view = [[HomeViewController alloc] init];
        //[self.navigationController pushViewController:view animated:YES];
        [UIView  beginAnimations:nil context:NULL];  
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];  
        [UIView setAnimationDuration:0.75];  
        [self.navigationController pushViewController:view animated:NO];  
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];  
        [UIView commitAnimations];
    }
    
}
@end
