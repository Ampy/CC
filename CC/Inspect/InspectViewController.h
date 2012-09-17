//
//  InspectViewController.h
//  Construction
//
//  Created by  rtsafe02 on 12-9-5.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Models/InspectModel.h"
#import "../Services/InspectService.h"
#import "FirstItemViewController.h"
#import "SecondItemViewController.h"
#import "InspectTableViewCell.h"
#import "ManageViewController.h"

@class SecondItemViewController;
@class FirstItemViewController;

@interface InspectViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *InspectList;
    NSString *InspectActivityId;
}
//@property (weak, nonatomic) IBOutlet UITableView *InspectsTableView;

@property(nonatomic,retain) NSMutableArray *InspectList;

@property (strong, nonatomic) IBOutlet UIView *FirstItemViewContainer;

-(InspectViewController *)initWithInspectActivityId:(NSString *)inspectActivityId;

@property (strong, nonatomic) IBOutlet FirstItemViewController *firstItemViewController;
@property (strong, nonatomic) IBOutlet SecondItemViewController *secondItemViewController;


@property (strong, nonatomic) IBOutlet UIView *SecondItemViewContainer;
@property (strong, nonatomic) IBOutlet UITableView *InspectTableView;

@end
