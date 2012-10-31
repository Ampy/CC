//
//  InputSubView.m
//  WMSG
//
//  Created by fy ren on 12-9-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InputSubView.h"

@implementation InputSubView

@synthesize delegate;
@synthesize index;

- (id)initWithFrame:(CGRect)frame index:(int)i
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"InputSubView" owner:self options:nil];
        UIView * tmp = [nib objectAtIndex:0];
        [self addSubview:tmp];
        
        
        UIButton *outButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [outButton setFrame:CGRectMake(260, 5, 54, 31)];
        [outButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        [outButton setTitle:@"关闭" forState:UIControlStateNormal];
        [self addSubview:outButton];
        [outButton addTarget:self  action:@selector(outButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.userInteractionEnabled = YES;
        
        index = i;
        if(index==0)
        {
            lists = [LogicBase GetLine];
        }
        else
        {
            lists = [LogicBase GetSite];
        }
    }
    return self;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
-(void)outButton:(id)sender
{
    [delegate SubVewClose];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [lists count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @""] ;
    NSMutableArray * arr = [lists objectAtIndex:indexPath.row];
    //UITableViewCell *oneCell = [tableView cellForRowAtIndexPath: indexPath];
    
    if([[arr objectAtIndex:2] isEqualToString:@"Y"])
    {
        //cell.textLabel.frame = CGRectMake(10,0,250,43);
        cell.textLabel.text = [arr objectAtIndex:0];
        
        
        if([[arr objectAtIndex:3] isEqualToString:@"Y"])
        {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(270,10,22,22)];
            img.tag = 99;
            img.image = [UIImage imageNamed:@"up.png"];
            [cell.contentView addSubview:img];
        }
        else
        {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(270,10,22,22)];
            img.tag = 99;
            img.image = [UIImage imageNamed:@"down.png"];
            [cell.contentView addSubview:img];
        }
        
        
        
        
    }
    else
    {
        cell.textLabel.text = [@"        " stringByAppendingString: [arr objectAtIndex:0]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray * arr = [lists objectAtIndex:indexPath.row];
    if([[arr objectAtIndex:2] isEqualToString:@"Y"])
    {
        if([[arr objectAtIndex:3] isEqualToString:@"N"])
        {
            //[Config SetPlistInfo:@"LineID" Value:[arr objectAtIndex:1]];            
            [Settings setLineID :[arr objectAtIndex:1]];
            
            listSegment = [LogicBase GetSegment];
            
            UITableViewCell *oneCell = [tableView cellForRowAtIndexPath: indexPath];
            for(id x in [oneCell.contentView subviews])
            {
                if([x isKindOfClass:[UIImageView class]])
                {
                    UIImageView *img = x;
                    img.image = [UIImage imageNamed:@"up.png"];
                }
            }
            
            [[lists objectAtIndex:indexPath.row] setObject:@"Y" atIndex:3];
            
            NSMutableArray *insertion = [[NSMutableArray alloc] init] ;
            int row;
            for (int i = 1; i <= listSegment.count; ++i)
            {
                row = indexPath.row+i;
                [lists insertObject:[listSegment objectAtIndex:i-1] atIndex:row];
                [insertion addObject:[NSIndexPath indexPathForRow:row inSection:0]];
            }
            [tableView insertRowsAtIndexPaths:insertion withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }
        else
        {
            //[Config SetPlistInfo:@"LineID" Value:[arr objectAtIndex:1]];
            [Settings setLineID:[arr objectAtIndex:1]];
            listSegment = [LogicBase GetSegment];
            
            UITableViewCell *oneCell = [tableView cellForRowAtIndexPath: indexPath];
            for(id x in [oneCell.contentView subviews])
            {
                if([x isKindOfClass:[UIImageView class]])
                {
                    UIImageView *img = x;
                    img.image = [UIImage imageNamed:@"down.png"];
                }
            }
            
            [[lists objectAtIndex:indexPath.row] setObject:@"N" atIndex:3];
            
            NSMutableArray *insertion = [[NSMutableArray alloc] init] ;
            int row;
            for (int i = 1; i <= listSegment.count; ++i)
            {
                row = indexPath.row+i;
                [lists removeObjectAtIndex:indexPath.row+1];
                [insertion addObject:[NSIndexPath indexPathForRow:row inSection:0]];
            }
            [tableView deleteRowsAtIndexPaths:insertion withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }
    }
    else
    {
        if(index==0)
        {
            //[Config SetPlistInfo:@"SegmentID" Value:[arr objectAtIndex:1]];
            [Settings setSegmentID:[arr objectAtIndex:1]];
            
        }
        else
        {
            [Settings setSiteID:[arr objectAtIndex:1]];
            //[Config SetPlistInfo:@"SiteID" Value:[arr objectAtIndex:1]];
        }
        
        [delegate passValue:arr arrayIndex:index];
        [delegate SubVewClose];
    }
    
}

@end
