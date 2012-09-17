//
//  FirstItemViewController.h
//  Construction
//
//  Created by  rtsafe02 on 12-9-5.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Services/InspectService.h"
#import "SecondItemViewController.h"
#import "../Models/InspectItemModel.h"
//

@class SecondItemViewController;

@interface FirstItemViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *ItemList;
}
@property(nonatomic,retain) NSMutableArray *ItemList;
@property (strong, nonatomic) IBOutlet UITableView *FirstItemTableView;
@property (strong, nonatomic) IBOutlet SecondItemViewController *secondItemViewController;

-(void) LoadData:(NSString *)inspectId ParentItemId:(NSString *)parentItemId;
@end
