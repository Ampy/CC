//
//  PopViewController.h
//  PopViewTest
//
//  Created by  rtsafe02 on 12-9-7.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "InspectService.h"
#import "ThirdLevelTableViewCell.h"
#import "MCSegmentedControl.h"
#import "SwitchDelegate.h"

@protocol CloseViewDelegate <NSObject>

- (void)DoCloserView;

@end


@interface PopViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *ItemList;
}


-(id) initWithParentFrame:(CGRect )parentFrame;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (nonatomic, retain) id <CloseViewDelegate> closeDelegate;

@property(nonatomic,retain) NSMutableArray *ItemList;

@property (weak, nonatomic) IBOutlet UITableView *ThirdItemTableView;
@property (weak, nonatomic) IBOutlet UIView *ContentView;

-(void) LoadData:(NSString *)inspectId ParentItemId:(NSString *)parentItemId;

@property (weak, nonatomic) IBOutlet UILabel *PopTitleLabel;

@property (nonatomic, retain) id <SwitchDelegate> CancelSwitchDelegate;

@end
