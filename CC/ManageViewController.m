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
    
    UIButton *button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    button1.tag = 1;
    [button1 setFrame:CGRectMake(0, 50, 16, 14)];
    [button1 setBackgroundImage:[UIImage imageNamed:@"ok.png"] forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [button1 addTarget:self  action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(20, 10, 68, 26)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self  action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.userInteractionEnabled = YES;

    
    
    lists = [[NSMutableArray alloc]init];

    [lists addObject:[[NSMutableArray alloc]initWithObjects:@"apple",@"F",@"L",nil]];
    [lists addObject:[[NSMutableArray alloc]initWithObjects:@"banana",@"F",@"L",nil]];
    [lists addObject:[[NSMutableArray alloc]initWithObjects:@"cup",@"F",@"L",nil]];
    [lists addObject:[[NSMutableArray alloc]initWithObjects:@"desk",@"F",@"L",nil]];
    
    //[self setExtraCellLineHidden:DataTable];
    
    //[DataTable setBackgroundView:nil];
    //[DataTable setBackgroundView:[[[UIView alloc] init] autorelease]];
}

-(void)clickButton:(id)sender 
{
    UIButton* btn =(UIButton*)sender;
    if(btn.tag==1)
    {
        btn.tag = 2;
        [btn setFrame:CGRectMake(20, 50, 15, 11)];
        [btn setBackgroundImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    }
    else
    {
        btn.tag = 1;
        [btn setFrame:CGRectMake(20, 50, 16, 14)];
        [btn setBackgroundImage:[UIImage imageNamed:@"ok.png"] forState:UIControlStateNormal];
    }
    
}

-(void)backButton:(id)sender 
{
    //HomeViewController *ctrl = [[HomeViewController alloc] init];
    //[self.navigationController pushViewController:ctrl animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark -- Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [lists count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    //    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    //    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    //    if (cell == nil) 
    //    {  
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: SimpleTableIdentifier] ;
    //    }
    //cell.imageView.image=image;//未选cell时的图片
    //cell.imageView.highlightedImage=highlightImage;//选中cell后的图片
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @""] ;
    
    NSMutableArray * arr = [lists objectAtIndex:indexPath.row];
//    cell.text= [arr objectAtIndex:0];
//    if([arr objectAtIndex:1]==@"T")
//        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    UILabel *CellLabel= [[UILabel alloc] initWithFrame:CGRectMake(50,0,200,30)];
    //cell.accessoryView= CellLabel 
    //CellLabel.numberOfLines= 2;
    CellLabel.text = [arr objectAtIndex:0];
    CellLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size: 20.0 ]; 

    //CellLabel.shadowColor = [ UIColor grayColor ]; 
    //CellLabel.shadowOffset = CGSizeMake(0, 2); 
   
    [cell.contentView addSubview:CellLabel];
    
    UILabel *bLabel= [[UILabel alloc] initWithFrame:CGRectMake(50,30,200,20)];
    bLabel.text = @"XXXXX-XXXXX-XXXXXXX";
    bLabel.font = [UIFont fontWithName: @"Helvetica" size: 12 ];
    bLabel.textColor = [ UIColor grayColor ];
    [cell.contentView addSubview:bLabel];
    
    if(tableView.tag==2)
    {
        cell.imageView.image = [ UIImage imageNamed: @"icon_inspect_edit.png" ];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(360,15,15,11)];
        img.image = [UIImage imageNamed:@"arrow.png"];
        [cell.contentView addSubview:img];
        
        UILabel *imgLabel= [[UILabel alloc] initWithFrame:CGRectMake(380,5,100,30)];
        imgLabel.text = @"继续";
        imgLabel.textColor = [ UIColor redColor ];
        [cell.contentView addSubview:imgLabel];
    }
    else 
    {
        cell.imageView.image = [UIImage imageNamed:@"icon_inspect.png"];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(340,15,16,14)];
        img.image = [UIImage imageNamed:@"ok.png"];
        [cell.contentView addSubview:img];
        
        UILabel *imgLabel= [[UILabel alloc] initWithFrame:CGRectMake(360,5,100,30)];
        imgLabel.text = @"2012-9-5";
        [cell.contentView addSubview:imgLabel];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


@end
