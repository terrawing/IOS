//
//  Equipment.h
//  Equip
//
//  Created by William Wong on 2014-03-16.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Equipment : NSManagedObject

@property (nonatomic, retain) NSString * manufacturer;
@property (nonatomic, retain) NSString * brand;
@property (nonatomic, retain) NSString * modelCode;
@property (nonatomic, retain) NSString * orderCode;
@property (nonatomic, retain) NSString * colour;
@property (nonatomic, retain) id photo;
@property (nonatomic, retain) NSNumber * wsObjectId;

@end
