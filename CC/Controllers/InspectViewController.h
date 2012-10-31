//
//  InspectViewController.h
//  Construction
//
//  Created by  rtsafe02 on 12-9-5.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InspectModel.h"
#import "InspectService.h"
#import "FirstItemViewController.h"
#import "SecondItemViewController.h"
#import "InspectTableViewCell.h"
#import "ManageViewController.h"


@class SecondItemViewController;
@class FirstItemViewController;

@interface InspectViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    //检查表数组，装载查询出来的检查表
    NSMutableArray *InspectList;
    
    //当前检查活动ID
    NSString *InspectActivityId;
    

}

@property(nonatomic,retain) NSMutableArray *InspectList;


@property (strong, nonatomic) IBOutlet FirstItemViewController *firstItemViewController;

@property (strong, nonatomic) IBOutlet SecondItemViewController *secondItemViewController;

@property (weak, nonatomic) IBOutlet UITableView *InspectTableView;



-(InspectViewController *)initWithInspectActivityId:(NSString *)inspectActivityId;

@end
