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
    webView.userInteractionEnabled = NO;
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    
    //将config.plist复制到Documents目录下，以便读写
    [self copyPlistFile];

    if([@"F" isEqualToString:[Settings IsInit]])
    {
        [Common Alert:@"数据初始化，不同的网络情况需要5~10分钟。请耐心等待！切勿关闭或退出！！！"];
    }
    
    [self performSelectorInBackground: @selector(UpdateAndGoto) withObject: nil];
    
    }

-(void) UpdateAndGoto
{
    //[NSThread sleepForTimeInterval:1];
    
    //if(![Common ExceptionHandler:[Common CheckNetworkStatus]])
    //{
        [Common ExceptionHandler:[LogicBase UpdateByService]];
    //}
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

-(void)copyPlistFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentLibraryFolderPath = [documentsDirectory stringByAppendingPathComponent:@"config.plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:documentLibraryFolderPath]) {
        
        NSLog(@"文件已经存在了");
    }else {
        //    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fullPathToFile ofType:@"plist"];
        
        NSString *resourceSampleImagesFolderPath =[[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
        NSData *mainBundleFile = [NSData dataWithContentsOfFile:resourceSampleImagesFolderPath];
        [[NSFileManager defaultManager] createFileAtPath:documentLibraryFolderPath contents:mainBundleFile attributes:nil];
    }
    
}

@end
