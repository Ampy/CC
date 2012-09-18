//
//  FirstItemViewController.h
//  Construction
//
//  Created by  rtsafe02 on 12-9-5.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InspectService.h"
#import "SecondItemViewController.h"
#import "InspectItemModel.h"
#import "SwitchDelegate.h"

@class SecondItemViewController;

@interface FirstItemViewController : UIViewController<SwitchDelegate,UITableViewDelegate,UITableViewDataSource>
{
    //检查项数组，装载查询出来的检查项
    NSMutableArray *ItemList;
    //当前选中Cell里的Switch
    DCRoundSwitch *SelectedSwitch;
    //Switch数组，装载TableView里的所有Cell里的Switch
    NSMutableArray *SwitcherList;
}

@property (weak, nonatomic) IBOutlet UITableView *FirstItemTableView;

@property (weak, nonatomic) IBOutlet SecondItemViewController *secondItemViewController;

-(void) LoadData:(NSString *)inspectId ParentItemId:(NSString *)parentItemId;
@end
