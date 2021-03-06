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
@synthesize WaitWebView;


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
    queue = dispatch_queue_create("ampy",nil);
    
    SecondItemTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if(SwitcherList==nil)
        SwitcherList = [[NSMutableArray alloc] initWithCapacity:0];
    if(ItemStatusList==nil)
        ItemStatusList=[[NSMutableArray alloc] initWithCapacity:0];
    
    [super viewDidLoad];
    
    //UIButton *mp=[[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 45)];
    //[mp setTitle:@"" forState:0];
    //[mp addTarget:self  action:@selector(outButton:) forControlEvents:UIControlEventTouchUpInside];
    //[SecondItemTableView addSubview:mp];
	// Do any additional setup after loading the view.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    //dispatch_release(queue);
    // Release any retained subviews of the main view.
}

-(void) LoadData:(NSString *)inspectId ParentItemId:(NSString *)parentItemId
{
    dispatch_async(queue, ^{
        
        dispatch_sync(dispatch_get_main_queue(),^{
            WaitWebView.hidden=false;
            [WaitWebView setNeedsDisplay];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            InspectService * inspectService = [[InspectService alloc] init];
            
            ItemList = [inspectService GetInspectItems:inspectId ParentItemId:parentItemId];
            [SwitcherList removeAllObjects];
            [ItemStatusList removeAllObjects];
  
            [SecondItemTableView reloadData];
 
        });
        
        dispatch_async(dispatch_get_main_queue(),^{
            //int i=[SecondItemTableView.visibleCells count];
            WaitWebView.hidden=true;
            [WaitWebView setNeedsDisplay];
        });
        
    });
    

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
    
    InspectItemModel *model = (InspectItemModel*)[ItemList objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.InspectItemID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:model.InspectItemID];
        
        cell.selectedBackgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_ins3.png"]];
        
        
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
        bool mp = count!=0;
        
        UIImageView *ItemStatus=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ItemComplete.png"]];
        ItemStatus.frame=CGRectMake(500, 10, 40, 40);
        
        ItemStatus.hidden=mp;
        [ItemStatus setNeedsDisplay];
        
        [cell.contentView addSubview:ItemStatus];
        
        [ItemStatusList addObject:ItemStatus];
        
    }
    else
    {
        InspectItemModel *model = (InspectItemModel*)[ItemList objectAtIndex:indexPath.row];
        
        for(UIView *view in cell.contentView.subviews)
        {
            if([view isKindOfClass:[DCRoundSwitch class]])
            {
                DCRoundSwitch * switcher = (DCRoundSwitch *)view;
                [switcher setOn:model.IsCancel.integerValue==1?YES:NO animated:YES ignoreControlEvents:YES];
                [SwitcherList addObject:view];
            }
            if([view isKindOfClass:[UIImageView class]])
            {
                UIImageView * image=(UIImageView *)view;
                if(isCancelAll)
                {
                    image.hidden=model.IsCancel.integerValue!=1;
                }
                [ItemStatusList addObject:view];
            }
        }
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_async(queue, ^{
        
        dispatch_sync(dispatch_get_main_queue(),^{
            WaitWebView.hidden=false;
            [WaitWebView setNeedsDisplay];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            InspectItemModel *model = [ItemList objectAtIndex:indexPath.row];
            
            //if(pop==nil)
            {
                pop = [[PopViewController alloc] initWithParentFrame:self.view.superview.superview.superview.superview.frame];
                pop.closeDelegate=self;
                pop.CancelSwitchDelegate=self;
            }
            pop.PopTitleLabel.text = model.Name;
            [pop.ItemList removeAllObjects];
            [pop.ThirdItemTableView reloadData];
            [pop.ThirdItemTableView.visibleCells count];
            [pop LoadData:model.InspectID ParentItemId:model.ItemTempID];
            [self.view.superview.superview.superview addSubview:pop.view];
            
            SelectedSwitch = [SwitcherList objectAtIndex:[indexPath row]];
            ItemStatusLabel = [ItemStatusList objectAtIndex:[indexPath row]];
            
        });
        
        dispatch_async(dispatch_get_main_queue(),^{
            //int i=[SecondItemTableView.visibleCells count];
            WaitWebView.hidden=true;
            [WaitWebView setNeedsDisplay];
        });
        
    });
    

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
    isCancelAll=false;
}

-(void) CancelSwitchChange:(id)sender
{
    popClean=true;
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
-(void) SetIsCancelAll:(bool) isCancel
{
    isCancelAll=isCancel;
}

@end
