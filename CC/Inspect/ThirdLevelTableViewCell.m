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


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

//-(int)LoadScoreItem:(InspectItemModel *)item;
//{
//
//    InspectService *inspectService = [[InspectService alloc] init];
//    
//    [ScoreItems removeAllObjects];
//    ScoreItems = [inspectService GetInspectScoreItems:item.InspectItemID];
//    InspectItemId = item.InspectItemID;
//
//    ScoreTableView.scrollEnabled=NO;
//    ScoreTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//
//    [ScoreSegmentedControl removeAllSegments];
//    int i=0;
//    int Count = [ScoreItems count];
//    ScoreLable.numberOfLines=Count;
//    for(ScoreItemModel *si in ScoreItems)
//    {
//        [ScoreSegmentedControl insertSegmentWithTitle:si.Name atIndex:i animated:YES];
//        if(si.Selected.integerValue==1)
//            ScoreSegmentedControl.selectedSegmentIndex=i;
//        ScoreLable.text = [ScoreLable.text stringByAppendingFormat:@"%@:%@\n",si.Name,si.Caption];
//        [TestSegment insertSegmentWithTitle:si.Name atIndex:i animated:YES];
//        i++;
//    }
//   
//    CGRect tmp = ScoreSegmentedControl.frame;
//    ScoreSegmentedControl.frame = CGRectMake(tmp.origin.x, tmp.origin.y,Count*40, tmp.size.height);
//    return [ScoreItems count];
//}
//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ScoreItems count];
    }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    isLoaded = NO;

    static NSString *simpleTableIdentifier=@"InspectScoreItem";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell==nil){
         cell=[[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    int row = indexPath.row;
    ScoreItemModel *model = (ScoreItemModel*)[ScoreItems objectAtIndex:row];
    
    //
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 600, 40)];
    label.text = model.Caption;
    [cell.contentView insertSubview:label aboveSubview:cell.textLabel];
    
    cell.textLabel.text=model.Name;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  

    return cell;
}

//-(void) SingleSelected:(id)sender
//{
//    DCRoundSwitch * switcher =(DCRoundSwitch *)sender;
//    ScoreItemModel *scoreItem =(ScoreItemModel *) switcher.object;
//    InspectService *service = [[InspectService alloc] init];
//    int value = switcher.isOn?1:0;
//    [service SelectInspectScoreItem:scoreItem.ScoreID value:value];
//    
//    
//    if(switcher.isOn)
//    {
//    for(DCRoundSwitch * s in ScoreSwitchItems)
//    {
//        if(s != switcher && s.isOn)
//        {
//            [s setOn:NO animated:YES ignoreControlEvents:true];
//        }
//    }
//    }
//
//}

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
