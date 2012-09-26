//
//  FirstItemViewController.m
//  Construction
//
//  Created by  rtsafe02 on 12-9-5.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "FirstItemViewController.h"

@interface FirstItemViewController ()

@end

@implementation FirstItemViewController
@synthesize FirstItemTableView;
@synthesize secondItemViewController;

static NSString *CellIdentifier = @"FirstItem";

#pragma mark Controller默认函数
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
        FirstItemTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	// Do any additional setup after loading the view.
    
    FirstItemTableView.backgroundColor = [UIColor clearColor];
    secondItemViewController.CancelSwitchDelegate=self;
    SwitcherList = [[NSMutableArray alloc] initWithCapacity:0];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark TableView事件
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
	return 60;
	
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ItemList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InspectItemModel *model = (InspectItemModel*)[ItemList objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.InspectItemID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:model.InspectItemID];
    
    cell.tag=[indexPath row];
    cell.selectedBackgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_ins2.png"]];
    

    
    //添加Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(88, 0,160, 60)];
    label.numberOfLines=0;
    label.backgroundColor = [UIColor clearColor];
    label.text = model.Name;
    [cell.contentView addSubview:label];
    cell.textLabel.hidden=true;
    //添加跳过Switch
    DCRoundSwitch *CancelSwitch =[[DCRoundSwitch alloc] initWithFrame:CGRectMake(5, 15, 78, 28)];
    CancelSwitch.tag=[indexPath row];
    CancelSwitch.onText=@"跳过";
    CancelSwitch.offText=@"打分";
    
    [CancelSwitch removeTarget:self action:@selector(CancelSwitchChange:) forControlEvents:UIControlEventValueChanged];
    CancelSwitch.object=model;
    
    [CancelSwitch setOn:model.IsCancel.integerValue==1 animated:YES ignoreControlEvents:true];
    
    [CancelSwitch addTarget:self action:@selector(CancelSwitchChange:) forControlEvents:UIControlEventValueChanged];
    
    CancelSwitch.onTintColor=[UIColor colorWithRed:0.69 green:0.015 blue:0.015 alpha:1.0];
   
    [SwitcherList addObject:CancelSwitch];
    
    [cell.contentView addSubview:CancelSwitch];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([ItemList count]>0)
    {
    InspectItemModel *model = [ItemList objectAtIndex:indexPath.row];
    
    [secondItemViewController LoadData:model.InspectID ParentItemId:model.ItemTempID];

    if(SwitcherList.count>0)
    SelectedSwitch = [SwitcherList objectAtIndex:[indexPath row]];
    }
    
}


#pragma mark UI事件
-(void) LoadData:(NSString *)inspectId ParentItemId:(NSString *)parentItemId
{
    [SwitcherList removeAllObjects];
    
    InspectService * inspectService = [[InspectService alloc] init];
    [ItemList removeAllObjects];
    
    ItemList = [inspectService GetInspectItems:inspectId ParentItemId:parentItemId];
    //为了缓存区分
    CellIdentifier=parentItemId;
    [FirstItemTableView reloadData];
    
    if([ItemList count]>0)
    {
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:FirstItemTableView didSelectRowAtIndexPath:ip];
    [FirstItemTableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }
    if([SwitcherList count]>0)
    SelectedSwitch=[SwitcherList objectAtIndex:0];
}

-(void) CancelSwitchChange:(id)sender
{
    DCRoundSwitch * switcher =(DCRoundSwitch *)sender;
    InspectItemModel *model =(InspectItemModel *) switcher.object;

    InspectService *service = [[InspectService alloc] init];
    int value = switcher.isOn?1:0;
    [service SetInspectItemCancel:model.InspectID ItemId:model.InspectItemID value:value Level:1];
    
    NSIndexPath *ip=[NSIndexPath indexPathForRow:switcher.tag inSection:0];
    [self tableView:FirstItemTableView didSelectRowAtIndexPath:ip];
    [FirstItemTableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
    [secondItemViewController SetIsCancelAll:true];
    [secondItemViewController.SecondItemTableView reloadData];
    
}

-(void) DoSwitchChange
{
    [SelectedSwitch setOn:false animated:NO ignoreControlEvents:YES];
}


@end
