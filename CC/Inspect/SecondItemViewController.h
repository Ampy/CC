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

@interface SecondItemViewController : UIViewController<CloseViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *ItemList;
    PopViewController *pop;
}

@property(nonatomic,retain) NSMutableArray *ItemList;

@property (strong, nonatomic) IBOutlet UITableView *SecondItemTableView;


-(void) LoadData:(NSString *)inspectId ParentItemId:(NSString *)parentItemId;
@end
