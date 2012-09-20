//
//  InspectViewController.m
//  Construction
//
//  Created by  rtsafe02 on 12-9-5.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "InspectViewController.h"

@interface InspectViewController ()

@end

@implementation InspectViewController
@synthesize firstItemViewController;
@synthesize secondItemViewController;
@synthesize InspectTableView;
@synthesize InspectList;

static NSString *CellIdentifier = @"Inspects";

#pragma mark Controller默认函数
-(InspectViewController *)initWithInspectActivityId:(NSString *)inspectActivityId
{
    self = [super init];
    if(self)
    {
        InspectActivityId=inspectActivityId;
    }
    return self;
}

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
    [self.InspectTableView registerNib:[UINib nibWithNibName:@"InspectTableViewCell" bundle:nil]
                forCellReuseIdentifier:CellIdentifier];
    InspectService * inspectService = [[InspectService alloc] init];
    InspectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    InspectList = [inspectService GetInspects:InspectActivityId];

    InspectTableView.backgroundColor = [UIColor clearColor];
    InspectTableView.opaque = NO;
    
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:InspectTableView didSelectRowAtIndexPath:ip];
    [InspectTableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom]; 
}

- (void)viewDidUnload
{
    [self setFirstItemViewController:nil];
    [self setSecondItemViewController:nil];
    [self setInspectTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark TableView事件
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [InspectList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    InspectModel *model = (InspectModel*)[InspectList objectAtIndex:indexPath.row];
    
    InspectTableViewCell *cell = (InspectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    cell.TableName.text = model.Name;
    //cell.TableImage.image=[UIImage imageNamed:@"InspectTable.png"];
    cell.selectedBackgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_ins1.png"]];


    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
    
}


- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
	return 100;
	
}

//选中行时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InspectModel *model = [InspectList objectAtIndex:indexPath.row];
    
    [firstItemViewController LoadData:model.InspectId ParentItemId:model.InspTempID];
}
- (IBAction)SaveButtonClick:(id)sender {
    ManageViewController *ctrl = [[ManageViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];

}

- (IBAction)CommitButtonClick:(id)sender {
    
    @try {
        InspectService * inspectService = [[InspectService alloc] init];
        if([inspectService CanCommitInspectActivity:InspectActivityId])
        {
        [inspectService InspectActivityComplete:InspectActivityId];
        }
        
        ManageViewController *ctrl = [[ManageViewController alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    @catch (NSException *exception) {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示" message: [exception reason] delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alert show];
    }
    @finally {
        
    }

}

@end
