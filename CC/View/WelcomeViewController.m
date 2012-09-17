//
//  WelcomeViewController.m
//  WMSG
//
//  Created by fy ren on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController
@synthesize webView;

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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // Do any additional setup after loading the view from its nib.
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"update" ofType:@"gif"]];
    webView.userInteractionEnabled = NO;//用户不可交互
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    
    
    //NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //[queue addOperationWithBlock:UpdateAndGoto];
    //dispatch_queue_t newThread = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //dispatch_async(newThread, ^{ [self UpdateAndGoto]; }); 
     [self performSelectorInBackground: @selector(UpdateAndGoto) withObject: nil];
    }

-(void) UpdateAndGoto
{
    //[NSThread sleepForTimeInterval:1];
    
    if(![Common ExceptionHandler:[Common CheckNetworkStatus]])
    {
        [Common ExceptionHandler:[LogicBase UpdateByService]];
    }
        
    LoginViewController *ctrl = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
    //HomeViewController *ctrl = [[HomeViewController alloc] init];
    //[self.navigationController pushViewController:ctrl animated:YES];

}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return ((interfaceOrientation ==UIDeviceOrientationLandscapeLeft)||(interfaceOrientation ==UIDeviceOrientationLandscapeRight));
}

@end
