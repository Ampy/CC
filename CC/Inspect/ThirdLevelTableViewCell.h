//
//  ThirdLevelTableViewCell.h
//  Construction
//
//  Created by  rtsafe02 on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InspectService.h"
#import "DCRoundSwitch.h"
#import "InspectItemModel.h"
#import "MCSegmentedControl.h"


@interface ThirdLevelTableViewCell: UITableViewCell<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *ScoreItems;
    NSString * InspectItemId;

}

@property (weak, nonatomic) IBOutlet UILabel *ItemName;
@property (weak, nonatomic) IBOutlet UILabel *ItemRemarks;

@property (weak, nonatomic) IBOutlet DCRoundSwitch *CancelSwitch;
@property (strong, nonatomic) IBOutlet MCSegmentedControl *ScoreSegmentedControl;
@property (weak, nonatomic)  UILabel *ScoreLable;
@property (weak, nonatomic)  UILabel *ScoreName;
@property (strong, nonatomic) NSArray *ScoreItems;
@property (weak, nonatomic) IBOutlet UITableView *ScoreTableView;

@end
