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
@synthesize SecondItemViewContainer;
@synthesize InspectTableView;
@synthesize FirstItemViewContainer;
//@synthesize InspectsTableView;

@synthesize InspectList;

static NSString *CellIdentifier = @"Inspects";


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
    InspectService * inspectService = [[InspectService alloc] init];
    InspectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    InspectList = [inspectService GetInspects:InspectActivityId];
    firstItemViewController.view.frame = CGRectMake(0, 0, FirstItemViewContainer.frame.size.width, 707);
    [self.FirstItemViewContainer addSubview:firstItemViewController.view];
    
    secondItemViewController.view.frame = CGRectMake(0, 0, SecondItemViewContainer.frame.size.width, 707);
    [self.SecondItemViewContainer addSubview:secondItemViewController.view];
    

    [self.InspectTableView registerNib:[UINib nibWithNibName:@"InspectTableViewCell" bundle:nil]
         forCellReuseIdentifier:CellIdentifier];
    
    //[InspectsTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
    //设置圆角边框

    InspectTableView.backgroundColor = [UIColor clearColor];
    InspectTableView.opaque = NO;
    InspectTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inspect_bg1.png"]];

    
    FirstItemViewContainer.backgroundColor = [UIColor clearColor];
    FirstItemViewContainer.opaque = NO;
    FirstItemViewContainer.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"inspect_bg2.png"]];
    
    FirstItemViewContainer.backgroundColor = [UIColor clearColor];
    FirstItemViewContainer.opaque = NO;
    FirstItemViewContainer.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"inspect_bg3.png"]];
}

- (void)viewDidUnload
{
    //[self setInspectsTableView:nil];
    [self setFirstItemViewContainer:nil];
    [self setFirstItemViewController:nil];
    [self setSecondItemViewController:nil];
    [self setSecondItemViewContainer:nil];
    [self setInspectTableView:nil];
    [self setFirstItemViewController:nil];
    [self setSecondItemViewController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [InspectList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    InspectModel *model = (InspectModel*)[InspectList objectAtIndex:indexPath.row];
    
    //static NSString *CellIdentifier = @"Inspects";
    
    /********自定义Cell的写法***********/

    InspectTableViewCell *cell = (InspectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    cell.TableName.text = model.Name;
    cell.TableImage.image=[UIImage imageNamed:@"Inspect.png"];
    //cell.Switcher.onText=@"跳过";
    //cell.Switcher.offText=@"未跳过";
    
    //[cell.Switcher removeTarget:self action:@selector(SingleSelected:) forControlEvents:UIControlEventValueChanged];
    //cell.Switcher.object=model;
    
    //[cell.Switcher setOn:model.IsCancel.integerValue==1 animated:YES ignoreControlEvents:true];
    
    //[cell.Switcher addTarget:self action:@selector(SingleSelected:) forControlEvents:UIControlEventValueChanged];
    cell.selectedBackgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_ins1.png"]];

    /*****另外一种方法
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
     
    CGRect nameLabelRect=CGRectMake(0, 72, 70, 15);
    
    UILabel *nameLabel=[[UILabel alloc] initWithFrame:nameLabelRect];
    
    nameLabel.textAlignment=UITextAlignmentRight;
    
    nameLabel.text=model.Name;
    
    nameLabel.font=[UIFont boldSystemFontOfSize:12];
    
    [cell.contentView addSubview:nameLabel];
    */
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
    
}

-(void) SingleSelected:(id)sender
{
//    DCRoundSwitch * switcher =(DCRoundSwitch *)sender;
//    ScoreItemModel *scoreItem =(ScoreItemModel *) switcher.object;
//    InspectService *service = [[InspectService alloc] init];
//    int value = switcher.isOn?1:0;
//    [service SetInspectItemCancel:scoreItem.ScoreID value:value];

}


- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
	return 100;
	
}

//选中行时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *continent = [self tableView:tableView titleForHeaderInSection:indexPath.section];
    InspectModel *model = [InspectList objectAtIndex:indexPath.row];
    
    [firstItemViewController LoadData:model.InspectId ParentItemId:model.InspTempID];
    
    //InspectTableViewCell *cell = (InspectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];


    
    //cell.BackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_ins1.png"]];
    
    //cell.backgroundView  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_ins1.png"]];
    
    
  //[InspectsTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (IBAction)BackClick:(id)sender {
    ManageViewController *ctrl = [[ManageViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (IBAction)CommitClick:(id)sender {
}

@end
