//
//  SecondViewController.h
//  Construction
//
//  Created by  rtsafe02 on 12-9-5.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Services/InspectService.h"
#import "../Models/InspectItemModel.h"
#import "PopViewController.h"
#import "SwitchDelegate.h"

@interface SecondItemViewController : UIViewController<CloseViewDelegate,UITableViewDelegate,UITableViewDataSource,SwitchDelegate>
{
    //检查项数组，装载查询出来的检查项
    NSMutableArray *ItemList;
    
    //弹出页
    PopViewController *pop;
    
    //当前选中Cell里的Switch
    DCRoundSwitch *SelectedSwitch;
    
    UIImageView *ItemStatusLabel;
    
    //Switch数组，装载TableView里的所有Cell里的Switch
    NSMutableArray *SwitcherList;
    
    NSMutableArray *ItemStatusList;
    
    bool isCancelAll;
    
}

@property(nonatomic,retain) NSMutableArray *ItemList;
@property(nonatomic,retain) NSMutableArray *SwitcherList;
@property(nonatomic,retain) NSMutableArray *ItemStatusList;
@property (nonatomic, retain) id <SwitchDelegate> CancelSwitchDelegate;
@property (weak, nonatomic) IBOutlet UITableView *SecondItemTableView;


-(void) LoadData:(NSString *)inspectId ParentItemId:(NSString *)parentItemId;

-(void) SetIsCancelAll:(bool) isCancel;
@end
