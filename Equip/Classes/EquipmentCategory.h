//
//  EquipmentCategory.h
//  Equip
//
//  Created by William Wong on 2014-03-16.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EquipmentCategory : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) id displayIcon;
@property (nonatomic, retain) NSString * nameOfEntity;
@property (nonatomic, retain) NSNumber * wsObjectId;

@end
