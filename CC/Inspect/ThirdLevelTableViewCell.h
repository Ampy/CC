//
//  ThirdLevelTableViewCell.h
//  Construction
//
//  Created by  rtsafe02 on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Services/InspectService.h"
#import "../Controls/Switch/DCRoundSwitch.h"
#import "../Models/InspectItemModel.h"


@interface ThirdLevelTableViewCell: UITableViewCell<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *ScoreItems;
    NSString * InspectItemId;
    //NSMutableArray *ScoreSwitchItems;
    //InspectItemModel *InspetItem;
}

@property (strong, nonatomic) IBOutlet UILabel *ItemName;
@property (strong, nonatomic) IBOutlet UILabel *ItemRemarks;

//-(int) LoadScoreItem:(InspectItemModel *)item;
@property (strong, nonatomic) IBOutlet DCRoundSwitch *CancelSwitch;
@property (strong, nonatomic) IBOutlet UISegmentedControl *ScoreSegmentedControl;
@property (strong, nonatomic) IBOutlet UILabel *ScoreLable;
@property (strong, nonatomic) IBOutlet UILabel *ScoreName;


@property (strong, nonatomic) NSArray *ScoreItems;
@property (strong, nonatomic) IBOutlet UITableView *ScoreTableView;

@end
