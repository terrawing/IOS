//
//  Team.h
//  Equip
//
//  Created by William Wong on 2014-03-16.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Team : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * teamName;
@property (nonatomic, retain) NSString * nameofEM;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * loginToken;
@property (nonatomic, retain) NSDate * loginTimestamp;
@property (nonatomic, retain) NSNumber * wsObjectId;

@end
