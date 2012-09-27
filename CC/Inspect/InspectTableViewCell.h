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
{
    NSString *InspectId;
}
@property (weak, nonatomic) IBOutlet UIImageView *TableImage;
@property (weak, nonatomic) IBOutlet UILabel *TableName;
@property (retain,nonatomic) NSString *InspectId;

-(void) initWithLeftRightName:(NSString *)leftText andRight:(NSString *)rightText;

@end
