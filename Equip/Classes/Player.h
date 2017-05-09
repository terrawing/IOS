//
//  Player.h
//  Equip
//
//  Created by William Wong on 2014-03-16.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Gloves, Helmet, SkateBoot, SkateHolder, SkateRunner, Stick;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * givenNames;
@property (nonatomic, retain) id photoHeadshot;
@property (nonatomic, retain) NSNumber * jerseyNumber;
@property (nonatomic, retain) NSString * position;
@property (nonatomic, retain) NSString * handedness;
@property (nonatomic, retain) NSString * playingStatus;
@property (nonatomic, retain) NSDate * birthDate;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSNumber * wsObjectId;
@property (nonatomic, retain) Gloves *gloves;
@property (nonatomic, retain) Helmet *helmet;
@property (nonatomic, retain) SkateBoot *skateBoot;
@property (nonatomic, retain) SkateHolder *skateHolder;
@property (nonatomic, retain) SkateRunner *skateRunner;
@property (nonatomic, retain) Stick *stick;

@end
