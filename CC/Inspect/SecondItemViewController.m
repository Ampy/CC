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
    InspectService * inspectService = [[InspectService alloc] init];
    
    ItemList = [inspectService GetInspectItems:inspectId ParentItemId:parentItemId];

    [SecondItemTableView reloadData];
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
    
    static NSString *CellIdentifier = @"SecondItem";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //}
      cell.selectedBackgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_ins3.png"]];
    InspectItemModel *model = (InspectItemModel*)[ItemList objectAtIndex:indexPath.row];
    //cell.textLabel.text=model.Name;
    //cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    //cell.textLabel.numberOfLines=0;
    
    //添加Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 10,370, 60)];
    label.text = model.Name;
    label.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:label];
    cell.textLabel.hidden=true;
    label.numberOfLines=0;
    
    //添加跳过Switch
    DCRoundSwitch *CancelSwitch =[[DCRoundSwitch alloc] initWithFrame:CGRectMake(8, 28, 80, 25)];
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
    
    //[secondItemViewController LoadData:model.InspectID ParentItemId:model.ItemTempID];
    
    if(pop==nil)
    {
    pop = [[PopViewController alloc] initWithParentFrame:self.view.superview.superview.frame];
        pop.closeDelegate=self;
    }
    pop.PopTitleLabel.text = model.Name;
    [pop LoadData:model.InspectID ParentItemId:model.ItemTempID];
    [self.view.superview.superview addSubview:pop.view];
}


-(void)DoCloserView{
    [pop.view removeFromSuperview];
}

-(void) SingleSelected:(id)sender
{
    DCRoundSwitch * switcher =(DCRoundSwitch *)sender;
    InspectItemModel *model =(InspectItemModel *) switcher.object;
    InspectService *service = [[InspectService alloc] init];
    int value = switcher.isOn?1:0;
    [service SetInspectItemCancel:model.InspectID ItemId:model.InspectItemID value:value Level:2];
    
}

@end
