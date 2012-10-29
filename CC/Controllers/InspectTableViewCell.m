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
@synthesize InspectId;


-(void) initWithLeftRightName:(NSString *)leftText andRight:(NSString *)rightText
{

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
  
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *) reuseIdentifier {
    return InspectId;
}

@end
