//
//  Gloves.h
//  Equip
//
//  Created by William Wong on 2014-03-16.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Equipment.h"

@class Player;

@interface Gloves : Equipment

@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) NSNumber * length;
@property (nonatomic, retain) NSSet *players;
@end

@interface Gloves (CoreDataGeneratedAccessors)

- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSSet *)values;
- (void)removePlayers:(NSSet *)values;

@end
