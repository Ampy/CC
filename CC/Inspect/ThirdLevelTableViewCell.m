//
//  ThirdLevelTableViewCell.m
//  Construction
//
//  Created by  rtsafe02 on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "ThirdLevelTableViewCell.h"
#import "../Controls/Switch/DCRoundSwitch.h"

@interface ThirdLevelTableViewCell ()

@end

@implementation ThirdLevelTableViewCell

@synthesize CancelSwitch;
@synthesize ScoreSegmentedControl;
@synthesize ScoreLable;
@synthesize ScoreName;

@synthesize ItemName;
@synthesize ItemRemarks;
@synthesize ScoreItems;
@synthesize ScoreTableView;


bool isLoaded=YES;
static NSString *simpleTableIdentifier=@"InspectScoreItem";

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        self.RemarkContainer.backgroundColor=[UIColor colorWithRed:0.68 green:0.68 blue:0.68 alpha:1.0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ScoreItems count];
    }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    isLoaded = NO;

    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell==nil){
         cell=[[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    
    cell.opaque=YES;
    
    int row = indexPath.row;
    ScoreItemModel *model = (ScoreItemModel*)[ScoreItems objectAtIndex:row];
    
    //
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 600, 40)];
    label.text = model.Caption;
    [cell.contentView insertSubview:label aboveSubview:cell.textLabel];
    
    cell.textLabel.text=model.Name;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
	return 40;
}


- (IBAction)ScoreItemSelected:(id)sender {

    NSInteger Index = ScoreSegmentedControl.selectedSegmentIndex;

    ScoreItemModel *scoreItem =[ScoreItems objectAtIndex:Index];
    InspectService *service = [[InspectService alloc] init];
    
    [service SelectInspectScoreItem:scoreItem.ScoreID value:1];
    
}


@end
