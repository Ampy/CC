//
//  SecondViewController.m
//  Construction
//
//  Created by  rtsafe02 on 12-9-5.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "SecondItemViewController.h"

@interface SecondItemViewController ()

@end

@implementation SecondItemViewController
@synthesize SecondItemTableView;
@synthesize ItemList;
@synthesize SwitcherList;
@synthesize ItemStatusList;
@synthesize CancelSwitchDelegate;

static NSString *CellIdentifier = @"SecondItem";

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
    SecondItemTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if(SwitcherList==nil)
        SwitcherList = [[NSMutableArray alloc] initWithCapacity:0];
    if(ItemStatusList==nil)
        ItemStatusList=[[NSMutableArray alloc] initWithCapacity:0];
        
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) LoadData:(NSString *)inspectId ParentItemId:(NSString *)parentItemId
{
    CellIdentifier=parentItemId;
    InspectService * inspectService = [[InspectService alloc] init];
    
    ItemList = [inspectService GetInspectItems:inspectId ParentItemId:parentItemId];
    [SwitcherList removeAllObjects];
    [ItemStatusList removeAllObjects];
    [SecondItemTableView reloadData];
    
    
//    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
//    [self tableView:SecondItemTableView didSelectRowAtIndexPath:ip];
//    [SecondItemTableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
//    
//    SelectedSwitch=[SwitcherList objectAtIndex:0];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
	return 80;
	
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return ItemList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
      cell.selectedBackgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_ins3.png"]];
    InspectItemModel *model = (InspectItemModel*)[ItemList objectAtIndex:indexPath.row];

    //添加Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 10,370, 60)];
    label.text = model.Name;
    label.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:label];
    cell.textLabel.hidden=true;
    label.numberOfLines=0;
    
    //添加跳过Switch
    DCRoundSwitch *CancelSwitch =[[DCRoundSwitch alloc] initWithFrame:CGRectMake(8, 28, 80, 28)];
    CancelSwitch.onText=@"跳过";
    CancelSwitch.offText=@"打分";
    
    [CancelSwitch removeTarget:self action:@selector(CancelSwitchChange:) forControlEvents:UIControlEventValueChanged];
    CancelSwitch.object=model;
    
    [CancelSwitch setOn:model.IsCancel.integerValue==1 animated:YES ignoreControlEvents:true];
    
    [CancelSwitch addTarget:self action:@selector(CancelSwitchChange:) forControlEvents:UIControlEventValueChanged];
    CancelSwitch.onTintColor=[UIColor colorWithRed:0.69 green:0.015 blue:0.015 alpha:1.0];
    
    [SwitcherList addObject:CancelSwitch];
    
    [cell.contentView addSubview:CancelSwitch];
    
    InspectService *service = [[InspectService alloc] init];
    int count = [service InspectItemScoreComplete:model.InspectItemID];
    
    UIImageView *ItemStatus=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ItemComplete.png"]];
        ItemStatus.frame=CGRectMake(500, 10, 40, 40);
    ItemStatus.hidden=count!=0;

    [cell.contentView addSubview:ItemStatus];
    
    [ItemStatusList addObject:ItemStatus];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    InspectItemModel *model = [ItemList objectAtIndex:indexPath.row];
    
    if(pop==nil)
    {
    pop = [[PopViewController alloc] initWithParentFrame:self.view.superview.superview.superview.superview.frame];
        pop.closeDelegate=self;
        pop.CancelSwitchDelegate=self;
    }
    pop.PopTitleLabel.text = model.Name;
    [pop LoadData:model.InspectID ParentItemId:model.ItemTempID];
    [self.view.superview.superview.superview addSubview:pop.view];
    
    SelectedSwitch = [SwitcherList objectAtIndex:[indexPath row]];
    ItemStatusLabel = [ItemStatusList objectAtIndex:[indexPath row]];
}


-(void)DoCloserView{
    [pop.view removeFromSuperview];
    InspectItemModel *model =(InspectItemModel *) SelectedSwitch.object;
    if(model)
    {
        InspectService *service = [[InspectService alloc] init];
        int count = [service InspectItemScoreComplete:model.InspectItemID];
        ItemStatusLabel.hidden=count!=0;
        [ItemStatusLabel setNeedsDisplay];
    }
}

-(void) CancelSwitchChange:(id)sender
{
    
    DCRoundSwitch * switcher =(DCRoundSwitch *)sender;
    InspectItemModel *model =(InspectItemModel *) switcher.object;
    InspectService *service = [[InspectService alloc] init];
    int value = switcher.isOn?1:0;
    [service SetInspectItemCancel:model.InspectID ItemId:model.InspectItemID value:value Level:2];
    
    UITableViewCell *cell = (UITableViewCell *)switcher.superview;
    UIImageView * label= [cell.subviews objectAtIndex:2];
    label.hidden= !switcher.isOn;
    [label setNeedsDisplay];
    
    if(CancelSwitchDelegate)
        [CancelSwitchDelegate DoSwitchChange];
}

-(void)DoSwitchChange
{
    [SelectedSwitch setOn:false animated:NO ignoreControlEvents:YES];
    if(CancelSwitchDelegate)
        [CancelSwitchDelegate DoSwitchChange];
}

@end
