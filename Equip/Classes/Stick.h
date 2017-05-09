//
//  Stick.h
//  Equip
//
//  Created by William Wong on 2014-03-16.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Equipment.h"

@class Player;

@interface Stick : Equipment

@property (nonatomic, retain) NSString * pattern;
@property (nonatomic, retain) NSString * leftRight;
@property (nonatomic, retain) NSNumber * curve;
@property (nonatomic, retain) NSNumber * flex;
@property (nonatomic, retain) NSSet *players;
@end

@interface Stick (CoreDataGeneratedAccessors)

- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSSet *)values;
- (void)removePlayers:(NSSet *)values;

@end
