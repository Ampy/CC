//
//  InputViewController.m
//  WMSG
//
//  Created by fy ren on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController ()

@end

@implementation InputViewController

@synthesize checkType;
@synthesize checkTypeName;
@synthesize tableView;

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
    
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(20, 10, 68, 26)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self  action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *beginButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [beginButton setFrame:CGRectMake(400, 620, 221, 52)];
    [beginButton setBackgroundImage:[UIImage imageNamed:@"btn_inspect.png"] forState:UIControlStateNormal];
    [beginButton addTarget:self  action:@selector(beginCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginButton];
    
    self.view.userInteractionEnabled = YES;
    

    listArr = [[NSMutableArray alloc] init];
    
    NSMutableArray *list1 = [[NSMutableArray alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init]; 
    [formatter setDateFormat:@"YYYY-MM-dd"]; 
    NSString *locationString=[formatter stringFromDate: [NSDate date]]; 
    
    [Config SetPlistInfo:@"InspectWay" Value:checkType];
    [Config SetPlistInfo:@"InspectDate" Value:locationString];

    [list1 addObject:[[NSMutableArray alloc]initWithObjects:@"检查类型",checkTypeName,nil]];
    [list1 addObject:[[NSMutableArray alloc]initWithObjects:@"检查人",[Config GetPlistInfo:@"LoginUserName"],nil]];
    [list1 addObject:[[NSMutableArray alloc]initWithObjects:@"检查时间",locationString,nil]];
    
    [listArr addObject:list1];
    
    NSMutableArray *list2 = [[NSMutableArray alloc] init];
    [list2 addObject:[[NSMutableArray alloc]initWithObjects:@"检查标段",@"未选标段",@"",@"",nil]];
    [list2 addObject:[[NSMutableArray alloc]initWithObjects:@"检查工程",@"未选工程",@"",@"",nil]];
    
    [listArr addObject:list2];
    
    NSMutableArray *list3 = [[NSMutableArray alloc] init];
    [list3 addObject:[[NSMutableArray alloc]initWithObjects:@"建设单位",@"未选单位",@"",@"",nil]];
    [list3 addObject:[[NSMutableArray alloc]initWithObjects:@"施工单位",@"未选单位",@"",@"",nil]];
    [list3 addObject:[[NSMutableArray alloc]initWithObjects:@"监理单位",@"未选单位",@"",@"",nil]];
    
    [listArr addObject:list3];
    
    [tableView setBackgroundView:nil];
}

-(void)backButton:(id)sender 
{
    //[self.navigationController popViewControllerAnimated:YES];
    HomeViewController *ctrl = [[HomeViewController alloc] init];
    [UIView  beginAnimations:nil context:NULL];  
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];  
    [UIView setAnimationDuration:0.75];  
    [self.navigationController pushViewController:ctrl animated:NO];  
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.navigationController.view cache:NO];  
    [UIView commitAnimations];
}

-(void)beginCheck:(id)sender 
{
    if([[[[listArr objectAtIndex:1] objectAtIndex:0] objectAtIndex:2] isEqualToString:@""])
    {
        [Common Alert:@"请选择标段！"];
        return;
    }
    if([[[[listArr objectAtIndex:1] objectAtIndex:1] objectAtIndex:2] isEqualToString:@""])
    {
        [Common Alert:@"请选择工程！"];
        return;
    }
    if([Common ExceptionHandler:[LogicBase BuildCheckData]])
        return;
    //开始检查
    //[Common Alert:@"开始检查"];
    
    NSString * mid = [Config GetPlistInfo:@"InspectActivityID"];
    InspectViewController * inspectview = [[InspectViewController alloc] initWithInspectActivityId:mid];
    [self.navigationController pushViewController:inspectview animated:YES];
    //[self presentModalViewController:inspectview animated:YES];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return ((interfaceOrientation ==UIDeviceOrientationLandscapeLeft)||(interfaceOrientation ==UIDeviceOrientationLandscapeRight));
}

#pragma mark -- Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [listArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[listArr objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @""] ;
    
    NSMutableArray * arr = [[listArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text= [arr objectAtIndex:0];
    
    if(indexPath.section==1)
    {
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if(indexPath.section==0)
    {
        UILabel *tLable= [[UILabel alloc] initWithFrame:CGRectMake(140,5,200,30)];
        tLable.text = [arr objectAtIndex:1];
        tLable.font = [UIFont fontWithName: @"Helvetica" size: 14 ];
        tLable.textColor = [ UIColor redColor ];
        tLable.textAlignment = UITextAlignmentRight;
        [tLable setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:tLable];
    }
    else 
    {
        UILabel *tLable= [[UILabel alloc] initWithFrame:CGRectMake(140,5,200,30)];
        if([[arr objectAtIndex:2] isEqualToString: @""])
        {
            tLable.text = [arr objectAtIndex:1];
            tLable.textColor = [ UIColor grayColor ];
            
        }
        else 
        {
            tLable.text = [arr objectAtIndex:2];
            tLable.textColor = [ UIColor redColor ];
        }
        //tLable.text = [arr objectAtIndex:1];
        tLable.font = [UIFont fontWithName: @"Helvetica" size: 14 ];
        
        tLable.textAlignment = UITextAlignmentRight;
        [tLable setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:tLable];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(IsOpenSubView) 
    {
        [subView removeFromSuperview];
    }
    if(indexPath.section==1)
    {
        int iRow = indexPath.row;
        if([[Config GetPlistInfo:@"SegmentID"] isEqualToString:@""])
        {
            iRow = 0;
        }
        
        int iHeight = 160;
        if(iRow==0)
        {
            iHeight = 110;
        }

        subView = [[InputSubView alloc]initWithFrame:CGRectMake(470, iHeight, 400, 420) index:iRow];
        subView.delegate = self;
        //subView.index = iRow;
        [self.view addSubview:subView];
        IsOpenSubView = YES;
    }
}


//
-(void)passValue:(NSMutableArray *)valueArr arrayIndex:(int) index
{
    //[LogicBase SetArrayLevel3:listArr Value:[valueArr objectAtIndex:0] Level1:1 Level2:index Level3:2];
    [[[listArr objectAtIndex:1] objectAtIndex:index] setObject:[valueArr objectAtIndex:0] atIndex:2];
    [[[listArr objectAtIndex:1] objectAtIndex:index] setObject:[valueArr objectAtIndex:1] atIndex:3];
    
    if(index==0)
    {
        [[[listArr objectAtIndex:2] objectAtIndex:0] setObject:[valueArr objectAtIndex:2] atIndex:2];
        [[[listArr objectAtIndex:2] objectAtIndex:0] setObject:[valueArr objectAtIndex:3] atIndex:3];
        
        [[[listArr objectAtIndex:1] objectAtIndex:1] setObject:@"" atIndex:2];
        [[[listArr objectAtIndex:1] objectAtIndex:1] setObject:@"" atIndex:3];
        [[[listArr objectAtIndex:2] objectAtIndex:1] setObject:@"" atIndex:2];
        [[[listArr objectAtIndex:2] objectAtIndex:1] setObject:@"" atIndex:3];
        [[[listArr objectAtIndex:2] objectAtIndex:2] setObject:@"" atIndex:2];
        [[[listArr objectAtIndex:2] objectAtIndex:2] setObject:@"" atIndex:3];
    }
    else 
    {
        [[[listArr objectAtIndex:2] objectAtIndex:1] setObject:[valueArr objectAtIndex:2] atIndex:2];
        [[[listArr objectAtIndex:2] objectAtIndex:1] setObject:[valueArr objectAtIndex:3] atIndex:3];
        [[[listArr objectAtIndex:2] objectAtIndex:2] setObject:[valueArr objectAtIndex:4] atIndex:2];
        [[[listArr objectAtIndex:2] objectAtIndex:2] setObject:[valueArr objectAtIndex:5] atIndex:3];
    }
    
    [tableView reloadData];
    
}

-(void)SubVewClose
{
    IsOpenSubView = NO;
    [subView removeFromSuperview];
}







@end
