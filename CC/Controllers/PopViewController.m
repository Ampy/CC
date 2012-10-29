//
//  PopViewController.m
//  PopViewTest
//
//  Created by  rtsafe02 on 12-9-7.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()

@end

@implementation PopViewController
@synthesize PopTitleLabel;
@synthesize ThirdItemTableView;
@synthesize ContentView;
@synthesize closeButton;
@synthesize ItemList;
@synthesize closeDelegate;
@synthesize CancelSwitchDelegate;

static NSString *CellIdentifier = @"ThridItemCell";


-(id) initWithParentFrame:(CGRect )parentFrame
{
    self=[super init];
    if(self)
    {
        // Initialization code
        float pwidth = parentFrame.size.height;
        float pheight = parentFrame.size.width;
        self.view.frame = CGRectMake(0,0,pwidth,pheight);
        
        self.ContentView.frame = CGRectMake(40, 40, pwidth-2*40, pheight-2*40);
        self.ContentView.autoresizesSubviews=true;
        self.ContentView.autoresizingMask= UIViewAutoresizingFlexibleWidth  |UIViewAutoresizingFlexibleHeight;
        //[self.view setBackgroundColor:[UIColor redColor]]; //设置视图背景颜色
        self.ContentView.layer.cornerRadius=10;    //设置弹出框为圆角视图
        self.ContentView.layer.masksToBounds = YES;
        self.ContentView.layer.borderWidth = 2;   //设置弹出框视图边框宽度
        self.ContentView.layer.borderColor = [[UIColor colorWithRed:0.50 green:0.10 blue:0.10 alpha:0.5] CGColor];   //设置弹出框边框颜色
        
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
		[self.closeButton setFrame:CGRectMake(0, 0, 44, 44)];
		self.closeButton.layer.shadowColor = [[UIColor blackColor] CGColor];
		self.closeButton.layer.shadowOffset = CGSizeMake(0,4);
		self.closeButton.layer.shadowOpacity = 0.3;
        
        
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)layoutSubviews {
}

- (void)viewDidUnload
{
    [self setCloseButton:nil];
    [self setThirdItemTableView:nil];
    [self setContentView:nil];
    [self setPopTitleLabel:nil];
      [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


#pragma mark - UI事件
- (IBAction)closeButtonClick:(id)sender {
    
    [closeDelegate DoCloserView];
}

#pragma mark - 类实例方法
-(void) LoadData:(NSString *)inspectId ParentItemId:(NSString *)parentItemId
{
    
    CellIdentifier=parentItemId;
    InspectService * inspectService = [[InspectService alloc] init];
    ItemList = [inspectService GetInspectItems:inspectId ParentItemId:parentItemId];
    [ThirdItemTableView reloadData];
    
}

#pragma mark - TableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ItemList count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    InspectItemModel *model = (InspectItemModel*)[ItemList objectAtIndex:indexPath.row];
    ThirdLevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.InspectItemID];
    if (cell == nil) {
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ThirdLevelTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        cell.ItemModel=model;
        
        cell.opaque=YES;
        
        cell.ScoreTableView.scrollEnabled=NO;
        cell.ScoreTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        cell.ItemName.text = model.Name;
        //cell.RemarkContainer.backgroundColor=[UIColor colorWithRed:0.68 green:0.68 blue:0.68 alpha:1.0];
        cell.ItemName.textColor = [UIColor colorWithRed:0.69 green:0.015 blue:0.015 alpha:1.0];
 
        if(model.Remarks.length>0)
        {
            
            cell.ItemRemarks.text = model.Remarks;
            cell.RemarkContainer.layer.cornerRadius=10;
            cell.RemarkContainer.layer.masksToBounds = YES;
            cell.RemarkContainer.layer.borderWidth = 2;   //设置弹出框视图边框宽度
            cell.RemarkContainer.layer.borderColor = [[UIColor colorWithRed:0.788 green:0.788 blue:0.788 alpha:0.5] CGColor];   //设置弹出框边框颜色
        }
        else
        {
            cell.RemarkContainer.hidden=true;
        }
        
        cell.CancelSwitch.onText=@"跳过";
        cell.CancelSwitch.offText=@"打分";
        
        [cell.CancelSwitch removeTarget:self action:@selector(CancelSwitchChange:) forControlEvents:UIControlEventValueChanged];
        cell.CancelSwitch.object=model;
        
        [cell.CancelSwitch setOn:model.IsCancel.integerValue==1 animated:NO ignoreControlEvents:true];
        
        [cell.CancelSwitch addTarget:self action:@selector(CancelSwitchChange:) forControlEvents:UIControlEventValueChanged];
        cell.CancelSwitch.onTintColor=[UIColor colorWithRed:0.69 green:0.015 blue:0.015 alpha:1.0];
        
        
        cell.ScoreSegmentedControl.hidden=model.IsCancel.integerValue==1;
        
        
        InspectService *inspectService = [[InspectService alloc] init];
        
        NSArray * ScoreItems = [inspectService GetInspectScoreItems:model.InspectItemID];
        cell.ScoreItems = [[NSArray alloc] initWithArray:ScoreItems];
        [cell.ScoreSegmentedControl removeAllSegments];
        cell.ScoreSegmentedControl.tintColor = [UIColor colorWithRed:0.69 green:0.015 blue:0.015 alpha:1.0];
        int i=0;
        int Count = [ScoreItems count];
        cell.ScoreLable.numberOfLines=0;
        cell.ScoreName.numberOfLines=0;
        cell.ScoreLable.text=@"";
        cell.ScoreName.text=@"";
        for(ScoreItemModel *si in ScoreItems)
        {
            [cell.ScoreSegmentedControl insertSegmentWithTitle:si.Name atIndex:i animated:YES];
            
            if(si.Selected.integerValue==1)
            {
                cell.ScoreSegmentedControl.selectedSegmentIndex=i;
            }
            cell.ScoreLable.text = [cell.ScoreLable.text stringByAppendingFormat:@"%@\n",si.Caption];
            cell.ScoreName.text = [cell.ScoreName.text stringByAppendingFormat:@"%@:\n",si.Name];
            i++;
        }
        
        
        CGRect tmp = cell.ScoreSegmentedControl.frame;
        int x = self.ContentView.frame.size.width-Count*40-40;
        cell.ScoreSegmentedControl.frame = CGRectMake(x, tmp.origin.y,Count*40, tmp.size.height);
        
        if(model.Remarks.length==0)
        {
            CGRect tmp2 = cell.frame;
            cell.ScoreTableView.frame=CGRectMake(30,60, tmp2.size.width, tmp2.size.height-80);
        }
        [cell.ScoreTableView reloadData];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    InspectItemModel *model = (InspectItemModel*)[ItemList objectAtIndex:indexPath.row];
    InspectService *service = [[InspectService alloc] init];
    int count = [service GetInspectSocreItemsCount:model.InspectItemID];
    if([model.Remarks length]==0)
        return 70+count*40;
    else
        return 135+count*40;
}


-(void) CancelSwitchChange:(id)sender
{
    DCRoundSwitch * switcher =(DCRoundSwitch *)sender;
    InspectItemModel *model =(InspectItemModel *) switcher.object;
    
    InspectService *service = [[InspectService alloc] init];
    int value = switcher.isOn?1:0;
    [service SetInspectItemCancel:model.InspectID ItemId:model.InspectItemID value:value Level:3];
    
    model.IsCancel  = [NSNumber numberWithInt:value];
    ThirdLevelTableViewCell *  cell =(ThirdLevelTableViewCell * )switcher.superview.superview;
    cell.ScoreSegmentedControl.selectedSegmentIndex =UISegmentedControlNoSegment;
    cell.ScoreSegmentedControl.hidden=value==1;
    [cell.ScoreSegmentedControl setNeedsDisplay];
    
    
    if(CancelSwitchDelegate)
        [CancelSwitchDelegate DoSwitchChange];
}

@end
