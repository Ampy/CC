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
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self.view setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed: @"login.jpg"]]];
    
    //UIButton *outButton =[UIButton buttonWithType:UIButtonTypeCustom];
    //[outButton setFrame:CGRectMake(580, 474, 98, 32)];
    //[outButton setBackgroundImage:[UIImage imageNamed:@"login_sumit.png"] forState:UIControlStateNormal];
    //[self.view addSubview:outButton];
    //[outButton addTarget:self  action:@selector(UserLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.userInteractionEnabled = YES;
    
//    NSString * isRemember = [Config GetPlistInfo:@"LoginIsRemember"];
//    if([isRemember isEqualToString: @"T"])
//    {
//        [remember setOn:true animated:NO];
        name.text = [Settings LoginUserName];
        //password.text = [Config GetPlistInfo:@"LoginPassword"];
//    }
//    else 
//    {
//        [remember setOn:false animated:NO];
//    }
    
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
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
	return ((interfaceOrientation ==UIDeviceOrientationLandscapeLeft)||(interfaceOrientation ==UIDeviceOrientationLandscapeRight));
}

- (IBAction)UserLogin:(id)sender {
    
//    if(remember.isOn)
//    {
    [Settings setLoginUserName:name.text];
//        [Config SetPlistInfo:@"LoginPassword" Value:password.text];
//        [Config SetPlistInfo:@"LoginIsRemember" Value:@"T"];
//    }
//    else
//    {
//        [Config SetPlistInfo:@"LoginIsRemember" Value:@"F"];
//    }
    
    NSMutableArray *loginArr = [LogicBase Login:name.text Password:password.text];
    
    if(loginArr.count==0)
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"登陆提示" message:@"用户名或密码错误！" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alert show];
    }
    else 
    {
        
        [Settings setLoginUserId:[loginArr objectAtIndex:0] ];
        [Settings setLoginUserName:[loginArr objectAtIndex:1] ];
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
- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
    
    //[textField resignFirstResponder];
}

-(void) keyboardWillHide:(NSNotification *)note
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
}

-(void) keyboardWillShow:(NSNotification *)note
{           
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    [UIView beginAnimations:nil context:NULL]; 
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];   
    CGRect rect = CGRectMake(0.0f, -150,width,height);
    self.view.frame = rect;
    [UIView commitAnimations];
 
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y +422 - (self.view.frame.size.height - 220);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset>0)
    {
    CGRect rect = CGRectMake(0.0f, -150,width,height);
    self.view.frame = rect;
    }
    [UIView commitAnimations];
}

@end
