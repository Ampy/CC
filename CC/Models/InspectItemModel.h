//
//  InspectItemModel.h
//  Construction
//
//  Created by  rtsafe02 on 12-9-6.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InspectItemModel : NSObject
{
    NSString *InspectItemID;//guid(38) NOT NULL,
    NSString *SiteInspItemTempID;//varchar(20) NOT NULL COLLATE NOCASE,
    NSString *ItemTempID;//varchar(20) NOT NULL COLLATE NOCASE,
    NSString *PItemTempID;//varchar(20) COLLATE NOCASE,
    NSString *Name;//varchar(100) COLLATE NOCASE,
    NSString *Remarks;//varchar(500) COLLATE NOCASE,
    NSString *SpecialItem;//varchar(50) COLLATE NOCASE,
    NSNumber *Score;//numeric,
    NSNumber *Sort;//integer,
    NSString *InspTempID;//varchar(20) NOT NULL COLLATE NOCASE,
    NSString *SiteInspTempID;//varchar(20) NOT NULL COLLATE NOCASE,
    NSString *InspectID;//guid(38) NOT NULL,
    NSNumber *Total;//numeric,
    NSNumber *IsCancel;//integer
}

@property(nonatomic,retain) NSString *InspectItemID;
@property(nonatomic,retain) NSString *SiteInspItemTempID;
@property(nonatomic,retain) NSString *ItemTempID;
@property(nonatomic,retain) NSString *PItemTempID;
@property(nonatomic,retain) NSString *Name;
@property(nonatomic,retain) NSString *Remarks;
@property(nonatomic,retain) NSString *SpecialItem;
@property(nonatomic,retain) NSNumber *Score;
@property(nonatomic,retain) NSNumber *Sort;
@property(nonatomic,retain) NSString *InspTempID;
@property(nonatomic,retain) NSString *SiteInspTempID;
@property(nonatomic,retain) NSString *InspectID;
@property(nonatomic,retain) NSNumber *Total;
@property(nonatomic,retain) NSNumber *IsCancel;

@end
