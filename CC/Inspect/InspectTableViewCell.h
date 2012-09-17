//
//  InspectTableViewCell.h
//  Construction
//
//  Created by  rtsafe02 on 12-9-6.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Controls/Switch/DCRoundSwitch.h"

@interface InspectTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *TableImage;
@property (strong, nonatomic) IBOutlet UILabel *TableName;


-(void) initWithLeftRightName:(NSString *)leftText andRight:(NSString *)rightText;
//+ (InspectTableViewCell *)cellFromNibNamed:(NSString *)nibName;


@end
