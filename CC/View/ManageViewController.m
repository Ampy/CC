//
//  ManageViewController.m
//  WMSG
//
//  Created by fy ren on 12-9-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ManageViewController.h"

@interface ManageViewController ()

@end

@implementation ManageViewController
@synthesize updateTableView;



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
    //[self setupPrototypes];
    // Do any additional setup after loading the view from its nib.
    
    //    UIButton *button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    //    button1.tag = 1;
    //    [button1 setFrame:CGRectMake(0, 50, 16, 14)];
    //    [button1 setBackgroundImage:[UIImage imageNamed:@"ok.png"] forState:UIControlStateNormal];
    //    [self.view addSubview:button1];
    //    [button1 addTarget:self  action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(20, 10, 68, 26)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self  action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    upButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [upButton setFrame:CGRectMake(400, 50, 54, 31)];
    [upButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [upButton setTitle:@"同步" forState:UIControlStateNormal];
    [self.view addSubview:upButton];
    [upButton addTarget:self  action:@selector(updateToService:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.userInteractionEnabled = YES;
    
    lists = [LogicBase GetInspectList1];
    lists2 = [LogicBase GetInspectList2];
    
    
}

//-(void)clickButton:(id)sender
//{
//    UIButton* btn =(UIButton*)sender;
//    if(btn.tag==1)
//    {
//        btn.tag = 2;
//        [btn setFrame:CGRectMake(20, 50, 15, 11)];
//        [btn setBackgroundImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
//    }
//    else
//    {
//        btn.tag = 1;
//        [btn setFrame:CGRectMake(20, 50, 16, 14)];
//        [btn setBackgroundImage:[UIImage imageNamed:@"ok.png"] forState:UIControlStateNormal];
//    }
//
//}

-(void)backButton:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    HomeViewController *ctrl = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

-(void)updateToService:(id)sender
{
    if(lists.count>0)
    {
        bgView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.alpha = 0.6;
        [self.view addSubview:bgView];
        
        webView = [[UIWebView alloc]initWithFrame:CGRectMake(410, 180, 198, 181)];
        NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"up" ofType:@"gif"]];
        webView.userInteractionEnabled = NO;
        webView.backgroundColor = [UIColor clearColor];
        webView.opaque = NO;
        [webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
        [self.view addSubview:webView];
    }
    
    for(int i=0;i<lists.count;i++)
    {
        NSString *strI = [NSString stringWithFormat:@"%d",i];
        [self performSelectorInBackground: @selector(updataByOne:) withObject:strI];
    }
}

-(void)updataByOne:(NSString *)strI
{
    submitCount += 1;
    int i= [strI intValue];
    NSString * total = [LogicBase UpdateToService:[[lists objectAtIndex:i]objectAtIndex:6]];
    [[lists objectAtIndex:i] setObject:total atIndex:5];
    if(submitCount==lists.count)
    {
        [webView removeFromSuperview];
        [bgView removeFromSuperview];
        upButton.enabled = NO;
    }
    [updateTableView reloadData];
}

- (void)viewDidUnload
{
    [self setUpdateTableView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return ((interfaceOrientation ==UIDeviceOrientationLandscapeLeft)||(interfaceOrientation ==UIDeviceOrientationLandscapeRight));
}

#pragma mark -- Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView.tag==2)
    {
        return [lists2 count];
    }
    else
    {
        return [lists count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @""] ;
    
    NSMutableArray * arr;
    if(tableView.tag==2)
    {
        arr= [lists2 objectAtIndex:indexPath.row];
    }
    else
    {
        arr= [lists objectAtIndex:indexPath.row];
    }
    
    
    UILabel *CellLabel= [[UILabel alloc] initWithFrame:CGRectMake(50,3,280,30)];
    
    CellLabel.text = [[[[arr objectAtIndex:3] stringByAppendingString:@"  "] stringByAppendingString:[arr objectAtIndex:4]] stringByReplacingOccurrencesOfString:@"0:00:00" withString:@""];
    CellLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size: 14.0 ];
    
    [cell.contentView addSubview:CellLabel];
    
    UILabel *bLabel= [[UILabel alloc] initWithFrame:CGRectMake(50,30,300,20)];
    bLabel.text = [[[arr objectAtIndex:0] stringByAppendingString:[arr objectAtIndex:1]] stringByAppendingString:[arr objectAtIndex:2]];
    bLabel.font = [UIFont fontWithName: @"Helvetica" size: 12 ];
    bLabel.textColor = [ UIColor grayColor ];
    [cell.contentView addSubview:bLabel];
    
    if(tableView.tag==2)
    {
        cell.imageView.image = [ UIImage imageNamed: @"icon_inspect_edit.png" ];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(380,20,15,11)];
        img.image = [UIImage imageNamed:@"arrow.png"];
        [cell.contentView addSubview:img];
        
        UILabel *imgLabel= [[UILabel alloc] initWithFrame:CGRectMake(400,10,100,30)];
        imgLabel.text = @"继续";
        imgLabel.textColor = [ UIColor redColor ];
        [cell.contentView addSubview:imgLabel];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_inspect.png"];
        
        if(![[arr objectAtIndex:5] isEqualToString:@""])
        {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(380,20,16,14)];
            img.image = [UIImage imageNamed:@"ok.png"];
            [cell.contentView addSubview:img];
            
            UILabel *imgLabel= [[UILabel alloc] initWithFrame:CGRectMake(400,10,100,30)];
            imgLabel.text = [arr objectAtIndex:5];
            [cell.contentView addSubview:imgLabel];
        }
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    if(tableView.tag==1)
//    {
//        NSString * mid = [[lists objectAtIndex:indexPath.row] objectAtIndex:6];
//        InspectViewController * inspectview = [[InspectViewController alloc] initWithInspectActivityId:mid];
//        [self.navigationController pushViewController:inspectview animated:YES];
//    }
    
    if(tableView.tag==2)
    {
        NSString * mid = [[lists2 objectAtIndex:indexPath.row] objectAtIndex:6];
        InspectViewController * inspectview = [[InspectViewController alloc] initWithInspectActivityId:mid];
        [self.navigationController pushViewController:inspectview animated:YES];
    }
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


@end
