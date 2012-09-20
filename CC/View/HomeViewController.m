//
//  HomeViewController.m
//  WMSG
//
//  Created by fy ren on 12-9-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController


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
    [self.view setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed: @"home_bg.png"]]];
    
    UIButton *button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    button1.tag = 1;
    [button1 setFrame:CGRectMake(255, 245, 128, 130)];
    [button1 setBackgroundImage:[UIImage imageNamed:@"sjcc_1.png"] forState:UIControlStateNormal];
    [self.view addSubview:button1];
    
    UIButton *button2 =[UIButton buttonWithType:UIButtonTypeCustom];
    button2.tag = 2;
    [button2 setFrame:CGRectMake(450, 245, 128, 130)];
    [button2 setBackgroundImage:[UIImage imageNamed:@"dqjc_1.png"] forState:UIControlStateNormal];
    [self.view addSubview:button2];
    
    UIButton *button3 =[UIButton buttonWithType:UIButtonTypeCustom];
    button3.tag = 3;
    [button3 setFrame:CGRectMake(645, 245, 128, 130)];
    [button3 setBackgroundImage:[UIImage imageNamed:@"fc_1.png"] forState:UIControlStateNormal];
    [self.view addSubview:button3];
    
    UIButton *button4 =[UIButton buttonWithType:UIButtonTypeCustom];
    button4.tag = 4;
    [button4 setFrame:CGRectMake(400, 570, 221, 52)];
    [button4 setBackgroundImage:[UIImage imageNamed:@"inspect2.png"] forState:UIControlStateNormal];
    [self.view addSubview:button4];
    
    UIButton *outButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [outButton setFrame:CGRectMake(950, 5, 54, 31)];
    [outButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [outButton setTitle:@"登出" forState:UIControlStateNormal];
    [self.view addSubview:outButton];
    
    [button1 addTarget:self  action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside]; 
    [button2 addTarget:self  action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside]; 
    [button3 addTarget:self  action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside]; 
    [button4 addTarget:self  action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [outButton addTarget:self  action:@selector(outButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.userInteractionEnabled = YES;
}

-(void)outButton:(id)sender 
{
    LoginViewController *view = [[LoginViewController alloc] init];
    [UIView  beginAnimations:nil context:NULL];  
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];  
    [UIView setAnimationDuration:0.75];  
    [self.navigationController pushViewController:view animated:NO];  
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];  
    [UIView commitAnimations];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return ((interfaceOrientation ==UIDeviceOrientationLandscapeLeft)||(interfaceOrientation ==UIDeviceOrientationLandscapeRight));
}

-(void)clickButton:(id)sender 
{
    UIButton* btn =(UIButton*)sender;
    
    if(btn.tag==4)
    {
        ManageViewController *ctrl = [[ManageViewController alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    else 
    {
        InputViewController *ctrl = [[InputViewController alloc] init];
        switch (btn.tag) 
        {
            case 1:
                ctrl.checkType =  @"随机抽查";
                break;
            case 2:
                ctrl.checkType =  @"定期检查";
                break;
            case 3:
                ctrl.checkType =  @"督导队复查";
                break;         
            default:
                break;
        }
        
        [UIView  beginAnimations:nil context:NULL];  
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];  
        [UIView setAnimationDuration:0.75];  
        [self.navigationController pushViewController:ctrl animated:NO];  
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];  
        [UIView commitAnimations];  
    }
}
@end