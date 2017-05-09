//
//  Model.h
//
//  Created by Peter McIntyre on 2012/06/22.
//  Copyright (c) 2012 Seneca College. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "CustomEntityClass.h"
#import "Team.h"
#import "Player.h"
#import "EquipmentCategory.h"
#import "Helmet.h"
#import "Gloves.h"
#import "SkateBoot.h"
#import "SkateHolder.h"
#import "SkateRunner.h"
#import "Stick.h"

@interface Model : NSObject

// For a 'get all' request
@property (nonatomic, strong) NSArray *helmetsGetAll;
@property (nonatomic, strong) NSArray *glovesGetAll;
@property (nonatomic, strong) NSArray *sticksGetAll;
@property (nonatomic, strong) NSArray *skatesGetAll;
- (void)gwGetAllRefresh:(NSString *)equipmentType andPropertyName:(NSString *)propertyName;

// For an 'add new' request
- (void)addNewEquipmentItem:(NSDictionary *)newItem andEquipmentName:(NSString *)equipmentType;
@property (nonatomic, strong) NSDictionary *editedGwItem;

// Data from the network
@property (nonatomic, strong) NSArray *dataFromNetwork;

// Fetched request
@property (nonatomic, strong) Team *fr_team; //custom getter to get the team core data stored already
- (Helmet *)helmetForPlayer:(Player *)player; //Fetch helmet with a player predicate
- (Gloves *)glovesForPlayer:(Player *)player; //Fetch gloves with a player predicate
- (Stick *)stickForPlayer:(Player *)player; //Fetch stick with a player predicate
- (SkateBoot *)skatesForPlayer:(Player *)player; //Fetch skates with a player predicate

// Fetched results controllers

@property (nonatomic, strong) NSFetchedResultsController *frc_entity;
@property (nonatomic, strong) NSFetchedResultsController *frc_players;
@property (nonatomic, strong) NSFetchedResultsController *frc_equipment_category;

//Fetched Login Token
@property (nonatomic, copy) NSString *authToken;

//date converter
- (NSDate *) NewDateFromYear:(int)year month:(int)month day:(int)day;

//Fetched team object
- (void)fetchTeamRequest:(NSString *)uname;
@property (nonatomic, strong) NSDictionary *fetchedTeam;

//Fetched Player object
- (void)fetchedPlayersRequest:(NSString *)wsObjId;
@property (nonatomic, strong) NSArray *fetchedPlayers;

// New object factories

- (id)addNew:(NSString *)entityName;

//Team
- (Team *)addNewTeam;

- (Team *)addNewTeam:(NSString *)city
        withTeamName:(NSString *)teamName
        withEquipMan:(NSString *)nameofEM
        withUserName:(NSString *)username
        withPassword:(NSString *)password
         aLoginToken:(NSString *)loginToken
        andLoginTime:(NSDate *)loginTimestamp
        alsoWSObject:(int)wsObjectId;

//Player
- (Player *)addNewPlayer;

- (Player *)addNewPlayer:(NSString *)lastName
            withGiveName:(NSString *)givenNames
               withImage:(UIImage *)photoHeadshot
            hasJerseyNum:(int)jerseyNumber
           playsPosition:(NSString *)position
                withHand:(NSString *)handedness
              haveStatus:(NSString *)playingStatus
                bornedOn:(NSDate *)birthDate
              withHeight:(int)height
              withWeight:(int)weight;

- (void)addNewPlayer:(NSDictionary *)pd; //by user


//Equipment Category
- (EquipmentCategory *)AddNewEquipmentCategory;

- (EquipmentCategory *)AddNewEquipmentCategory:(NSString *)displayName
                                       inOrder:(int)displayOrder
                                      withIcon:(UIImage *)displayIcon
                                     andEntity:(NSString *)nameOfEntity;

//Helmet
- (Helmet *)AddNewHelmet;

- (Helmet *)AddNewHelmet:(NSString *)manufacturer
               withBrand:(NSString *)brand
           withModelCode:(NSString *)modelCode
           withOrderCode:(NSString *)orderCode
              withColour:(NSString *)colour
               withImage:(UIImage *)photo
                withSize:(int)size
       withFaceProtector:(NSString *)faceProtector
           withChinStrap:(NSString *)chinStrap
               andPlayer:(Player *)player;

- (void)AddNewHelmet:(NSDictionary *)pd andPlayer:(Player *)player; //by user

//Gloves
- (Gloves *)AddNewGloves;

- (Gloves *)AddNewGloves:(NSString *)manufacturer
               withBrand:(NSString *)brand
           withModelCode:(NSString *)modelCode
           withOrderCode:(NSString *)orderCode
              withColour:(NSString *)colour
               withImage:(UIImage *)photo
                withSize:(int)size
              withLength:(int)length
               andPlayer:(Player *)player;

- (void)AddNewGloves:(NSDictionary *)pd andPlayer:(Player *)player; //by user

//Stick
- (Stick *)AddNewStick;

- (Stick *)AddNewStick:(NSString *)manufacturer
             withBrand:(NSString *)brand
         withModelCode:(NSString *)modelCode
         withOrderCode:(NSString *)orderCode
            withColour:(NSString *)colour
             withImage:(UIImage *)photo
           withPattern:(NSString *)pattern
         withLeftRight:(NSString *)leftRight
             withCurve:(int)curve
              withFlex:(int)flex
             andPlayer:(Player *)player;

- (void)AddNewStick:(NSDictionary *)pd andPlayer:(Player *)player; //by user

//Skates
- (SkateBoot *)AddNewSkates;

- (SkateBoot *)AddNewSkates:(NSString *)manufacturer
             withBrand:(NSString *)brand
         withModelCode:(NSString *)modelCode
         withOrderCode:(NSString *)orderCode
            withColour:(NSString *)colour
             withImage:(UIImage *)photo
                   withSize:(int)skateSize
              withStiffness:(int)stiffness
         withWidth:(NSString *)width
             andPlayer:(Player *)player;

- (void)AddNewSkates:(NSDictionary *)pd andPlayer:(Player *)player; //by user


// Data lifecycle

- (void)saveChanges;

@end
