//
//  InspectTableViewCell.m
//  Construction
//
//  Created by  rtsafe02 on 12-9-6.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import "InspectTableViewCell.h"
@interface InspectTableViewCell ()

@end

@implementation InspectTableViewCell

@synthesize TableImage;
@synthesize TableName;
//@synthesize CancelTable;

//@synthesize SwitchViewContainer;

-(void) initWithLeftRightName:(NSString *)leftText andRight:(NSString *)rightText
{
//    UICustomSwitch * sw = [UICustomSwitch switchWithLeftText:leftText andRight:rightText];
//    sw.on =true;
//    [SwitchViewContainer addSubview:sw];
//    Switcher.onText=@"打分";
//    Switcher.offText=@"跳过";
}

//+ (InspectTableViewCell *)cellFromNibNamed:(NSString *)nibName
//{
//    NSArray *array = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
//    
//    return [array objectAtIndex:0];
//}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"InspectTableViewCell" owner:self options:nil];
//        self = [array objectAtIndex:0];
//        
//        self.selectedBackgroundView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_ins1.png"]];
    }
  
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
