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
@synthesize ItemList;
@synthesize FirstItemTableView;
@synthesize secondItemViewController;

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
    FirstItemTableView.opaque = NO;
    FirstItemTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inspect_bg2.png"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
	return 60;
	
}


-(void) LoadData:(NSString *)inspectId ParentItemId:(NSString *)parentItemId
{
    InspectService * inspectService = [[InspectService alloc] init];
    [ItemList removeAllObjects];
    
    ItemList = [inspectService GetInspectItems:inspectId ParentItemId:parentItemId];

    [FirstItemTableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ItemList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"FirstItem";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //}
    
    cell.selectedBackgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_ins2.png"]];
    
    InspectItemModel *model = (InspectItemModel*)[ItemList objectAtIndex:indexPath.row];
    
    //添加Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(85, 0,200, 60)];
    label.backgroundColor = [UIColor clearColor];
    label.text = model.Name;
    [cell.contentView addSubview:label];
    cell.textLabel.hidden=true;
    //添加跳过Switch
    DCRoundSwitch *CancelSwitch =[[DCRoundSwitch alloc] initWithFrame:CGRectMake(5, 15, 80, 25)];
    CancelSwitch.onText=@"跳过";
    CancelSwitch.offText=@"未跳过";
    
    [CancelSwitch removeTarget:self action:@selector(SingleSelected:) forControlEvents:UIControlEventValueChanged];
    CancelSwitch.object=model;
    
    [CancelSwitch setOn:model.IsCancel.integerValue==1 animated:YES ignoreControlEvents:true];
    
    [CancelSwitch addTarget:self action:@selector(SingleSelected:) forControlEvents:UIControlEventValueChanged];
   
    
    [cell.contentView addSubview:CancelSwitch];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    InspectItemModel *model = [ItemList objectAtIndex:indexPath.row];
    
    [secondItemViewController LoadData:model.InspectID ParentItemId:model.ItemTempID];
}

-(void) SingleSelected:(id)sender
{
    DCRoundSwitch * switcher =(DCRoundSwitch *)sender;
    InspectItemModel *model =(InspectItemModel *) switcher.object;
    InspectService *service = [[InspectService alloc] init];
        int value = switcher.isOn?1:0;
    [service SetInspectItemCancel:model.InspectID ItemId:model.InspectItemID value:value Level:1];
    
}


@end
