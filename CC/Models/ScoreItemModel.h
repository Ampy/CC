//
//  InspectScoreItem.h
//  Construction
//
//  Created by  rtsafe02 on 12-9-10.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreItemModel : NSObject
{
    NSString * ScoreID;
    NSString * SiteScoreTempID;
    NSString * InspScoreTempID;
    NSString * Name;
    NSString * Caption;	
    NSNumber * Score;	
    NSNumber * Sort;
    NSString * InspItemTempID;;
    NSString * InspTempID;;
    NSString * SiteInspItemTempID;	
    NSString * SiteInspTempID;	
    NSString * InspectItemID;
    NSString * InspectID;	;
    NSNumber * Selected;
    NSString * Qualified;
}

@property(nonatomic,retain) NSString * ScoreID;
@property(nonatomic,retain) NSString * SiteScoreTempID;
@property(nonatomic,retain) NSString * InspScoreTempID;
@property(nonatomic,retain) NSString * Name;
@property(nonatomic,retain) NSString * Caption;
@property(nonatomic,retain) NSNumber * Score;
@property(nonatomic,retain) NSNumber * Sort;
@property(nonatomic,retain) NSString * InspItemTempID;;
@property(nonatomic,retain) NSString * InspTempID;;
@property(nonatomic,retain) NSString * SiteInspItemTempID;
@property(nonatomic,retain) NSString * SiteInspTempID;
@property(nonatomic,retain) NSString * InspectItemID;
@property(nonatomic,retain) NSString * InspectID;	;
@property(nonatomic,retain) NSNumber * Selected;
@property(nonatomic,retain) NSString * Qualified;

@end
