//
//  InspectModel.h
//  Construction
//
//  Created by  rtsafe02 on 12-9-5.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InspectModel : NSObject
{
    NSString *InspectId;
	NSString *InspectCode;  //varchar(50) NOT NULL COLLATE NOCASE,
	NSString *InspectWay;   //varchar(50) COLLATE NOCASE,
	NSString *SiteInspTempID;   //varchar(20) NOT NULL COLLATE NOCASE,
	NSString *SiteID;   //guid(38) NOT NULL,
	NSString *InspTempID;   //varchar(20) NOT NULL COLLATE NOCASE,
	NSString *Name;   //varchar(50) NOT NULL COLLATE NOCASE,
	NSNumber *Optional;   //integer NOT NULL,
	NSString *InspType;   //guid(38),
	NSString *Remarks;   //varchar(500) COLLATE NOCASE,
	NSNumber *Sort;   //integer NOT NULL,
	NSNumber *invalid;   //integer NOT NULL,
	NSNumber *Total;   //numeric,
	NSNumber *Score;   //numeric,
	NSNumber *Finished;   //integer NOT NULL,
	NSString *Inspecter;   //varchar(50) COLLATE NOCASE,
	NSDate *InspectDate;   //datetime,
	NSString *Recorder;   //varchar(50) COLLATE NOCASE,
	NSDate *RecordDate;   //datetime,
	NSString *InspectActivityID;   //guid(38),
	NSNumber *InspTempWeight;   //numeric DEFAULT 0,
	NSString *InspCategory;   //nvarchar(10) COLLATE NOCASE,
	NSNumber *IsCancel;   //nteger,
    
}

@property(nonatomic,retain) NSString *InspectId;
@property(nonatomic,retain) NSString *InspectCode;
@property(nonatomic,retain) NSString *InspectWay;
@property(nonatomic,retain) NSString *SiteInspTempID;   
@property(nonatomic,retain) NSString *SiteID;   
@property(nonatomic,retain) NSString *InspTempID;
@property(nonatomic,retain) NSString *Name;
@property(nonatomic,retain) NSNumber *Optional;
@property(nonatomic,retain) NSString *InspType;
@property(nonatomic,retain) NSString *Remarks;
@property(nonatomic,retain) NSNumber *Sort;
@property(nonatomic,retain) NSNumber *invalid;
@property(nonatomic,retain) NSNumber *Total;
@property(nonatomic,retain) NSNumber *Score;
@property(nonatomic,retain) NSNumber *Finished;
@property(nonatomic,retain) NSString *Inspecter;
@property(nonatomic,retain) NSDate *InspectDate;
@property(nonatomic,retain) NSString *Recorder;
@property(nonatomic,retain) NSDate *RecordDate;
@property(nonatomic,retain) NSString *InspectActivityID;
@property(nonatomic,retain) NSNumber *InspTempWeight;
@property(nonatomic,retain) NSString *InspCategory;
@property(nonatomic,retain) NSNumber *IsCancel;
@end
