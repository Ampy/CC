//
//  PopViewController.h
//  PopViewTest
//
//  Created by  rtsafe02 on 12-9-7.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "../Services/InspectService.h"
#import "ThirdLevelTableViewCell.h"

@protocol CloseViewDelegate <NSObject>

- (void)DoCloserView;

@end


@interface PopViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
        NSMutableArray *ItemList;

}


-(id) initWithParentFrame:(CGRect )parentFrame;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;

@property (nonatomic, retain) id <CloseViewDelegate> closeDelegate;

@property(nonatomic,retain) NSMutableArray *ItemList;

@property (strong, nonatomic) IBOutlet UITableView *ThirdItemTableView;
@property (strong, nonatomic) IBOutlet UIView *ContentView;

-(void) LoadData:(NSString *)inspectId ParentItemId:(NSString *)parentItemId;

@property (strong, nonatomic) IBOutlet UILabel *PopTitleLabel;

@end
