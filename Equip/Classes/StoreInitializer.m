//
//  StoreInitializer.m
//
//  Created by Peter McIntyre on 2012/06/26.
//  Copyright (c) 2012 Seneca College. All rights reserved.
//

#import "StoreInitializer.h"

@implementation StoreInitializer {}

+ (void)create:(Model *)model
{
    // Create objects
    // They get created in the managed object context object
    // Later, when the saveChanges message is sent, the Core Data infrastructure saves them to the store
    
#pragma mark - Team
    
    /*
    //Get the current year, month, day, hour and minute
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    //[DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    [DateFormatter setDateFormat:@"yyyy"];
    int year = [[DateFormatter stringFromDate:[NSDate date]] intValue];
    [DateFormatter setDateFormat:@"MM"];
    int month = [[DateFormatter stringFromDate:[NSDate date]] intValue];
    [DateFormatter setDateFormat:@"dd"];
    int day = [[DateFormatter stringFromDate:[NSDate date]] intValue];
    [DateFormatter setDateFormat:@"hh"];
    int hour = [[DateFormatter stringFromDate:[NSDate date]] intValue];
    [DateFormatter setDateFormat:@"mm"];
    int min = [[DateFormatter stringFromDate:[NSDate date]] intValue];
    
    Team *toMapleLeafs = [model addNewTeam:@"Toronto"
                              withTeamName:@"Maple Leafs"
                              withEquipMan:@"William Wong"
                              withUserName:@"william"
                              withPassword:@"passw0rd"
                               aLoginToken:@"abc123"
                              andLoginTime:[self NewDateFromYear:year month:month day:day hour:hour min:min]];
                                //andLoginTime:[self NewDateFromYear:2014 month:3 day:16]];
    
    // Save
    [model saveChanges];
    */
    
#pragma mark - Helmet
    
    
#pragma mark - Player
    
    /*
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"PKessel" ofType:@"jpg"];
    UIImage *playerImage = [UIImage imageWithContentsOfFile:imagePath];
    Player *player1 = [model addNewPlayer:@"Kessel"
                             withGiveName:@"Phil"
                                withImage:playerImage
                             hasJerseyNum:81
                            playsPosition:@"Right Wing"
                                 withHand:@"Right"
                               haveStatus:@"Active"
                                 bornedOn:[self NewDateFromYear:1987 month:10 day:2]
                               withHeight:183 //cm
                               withWeight:202];

    imagePath = nil, playerImage = nil;
    imagePath = [[NSBundle mainBundle] pathForResource:@"CFranson" ofType:@"jpg"];
    playerImage = [UIImage imageWithContentsOfFile:imagePath];
    Player *player2 = [model addNewPlayer:@"Franson"
                             withGiveName:@"Cody"
                                withImage:playerImage
                             hasJerseyNum:4
                            playsPosition:@"Defenceman"
                                 withHand:@"Right"
                               haveStatus:@"Active"
                                 bornedOn:[self NewDateFromYear:1987 month:8 day:8]
                               withHeight:196 //cm
                               withWeight:213];
    
    imagePath = nil, playerImage = nil;
    imagePath = [[NSBundle mainBundle] pathForResource:@"DClarkson" ofType:@"jpg"];
    playerImage = [UIImage imageWithContentsOfFile:imagePath];
    Player *player3 = [model addNewPlayer:@"Clarkson"
                             withGiveName:@"David"
                                withImage:playerImage
                             hasJerseyNum:71
                            playsPosition:@"Right Wing"
                                 withHand:@"Right"
                               haveStatus:@"Active"
                                 bornedOn:[self NewDateFromYear:1984 month:3 day:31]
                               withHeight:185 //cm
                               withWeight:200];
    
    imagePath = nil, playerImage = nil;
    imagePath = [[NSBundle mainBundle] pathForResource:@"JBernier" ofType:@"jpg"];
    playerImage = [UIImage imageWithContentsOfFile:imagePath];
    Player *player4 = [model addNewPlayer:@"Bernier"
                             withGiveName:@"Jonathan"
                                withImage:playerImage
                             hasJerseyNum:45
                            playsPosition:@"Goaltender"
                                 withHand:@"Left"
                               haveStatus:@"Active"
                                 bornedOn:[self NewDateFromYear:1988 month:8 day:7]
                               withHeight:183 //cm
                               withWeight:185];
    
    imagePath = nil, playerImage = nil;
    imagePath = [[NSBundle mainBundle] pathForResource:@"JGardiner" ofType:@"jpg"];
    playerImage = [UIImage imageWithContentsOfFile:imagePath];
    Player *player5 = [model addNewPlayer:@"Gardiner"
                             withGiveName:@"Jake"
                                withImage:playerImage
                             hasJerseyNum:51
                            playsPosition:@"Defenceman"
                                 withHand:@"Left"
                               haveStatus:@"Active"
                                 bornedOn:[self NewDateFromYear:1990 month:7 day:4]
                               withHeight:188 //cm
                               withWeight:184];
    
    imagePath = nil, playerImage = nil;
    imagePath = [[NSBundle mainBundle] pathForResource:@"JMcClement" ofType:@"jpg"];
    playerImage = [UIImage imageWithContentsOfFile:imagePath];
    Player *player6 = [model addNewPlayer:@"McClement"
                             withGiveName:@"Jay"
                                withImage:playerImage
                             hasJerseyNum:11
                            playsPosition:@"Centre"
                                 withHand:@"Left"
                               haveStatus:@"Active"
                                 bornedOn:[self NewDateFromYear:1983 month:3 day:2]
                               withHeight:185 //cm
                               withWeight:205];

    
    // Save
    [model saveChanges];
    */
    
#pragma mark - Equipment Category
    
    NSString *imagePath2 = [[NSBundle mainBundle] pathForResource:@"helmetCat" ofType:@"jpg"];
    UIImage *equipmentCategoryImage = [UIImage imageWithContentsOfFile:imagePath2];
    EquipmentCategory *helmet = [model AddNewEquipmentCategory:@"Helmet"
                                                       inOrder:10
                                                      withIcon:equipmentCategoryImage
                                                     andEntity:@"Helmet"];
    
    imagePath2 = nil; equipmentCategoryImage = nil;
    imagePath2 = [[NSBundle mainBundle] pathForResource:@"glovesCat" ofType:@"jpg"];
    equipmentCategoryImage = [UIImage imageWithContentsOfFile:imagePath2];
    EquipmentCategory *gloves = [model AddNewEquipmentCategory:@"Gloves"
                                                       inOrder:20
                                                      withIcon:equipmentCategoryImage
                                                     andEntity:@"Gloves"];
    
    imagePath2 = nil; equipmentCategoryImage = nil;
    imagePath2 = [[NSBundle mainBundle] pathForResource:@"skatesCat" ofType:@"jpg"];
    equipmentCategoryImage = [UIImage imageWithContentsOfFile:imagePath2];
    EquipmentCategory *skateBoot = [model AddNewEquipmentCategory:@"Skate Boot"
                                                          inOrder:30
                                                         withIcon:equipmentCategoryImage
                                                        andEntity:@"SkateBoot"];
    /*
    imagePath2 = nil; equipmentCategoryImage = nil;
    imagePath2 = [[NSBundle mainBundle] pathForResource:@"skateHolderCat" ofType:@"jpg"];
    equipmentCategoryImage = [UIImage imageWithContentsOfFile:imagePath2];
    EquipmentCategory *skateHolder = [model AddNewEquipmentCategory:@"Skate Holder"
                                                            inOrder:40
                                                           withIcon:equipmentCategoryImage
                                                          andEntity:@"SkateHolder"];
    
    imagePath2 = nil; equipmentCategoryImage = nil;
    imagePath2 = [[NSBundle mainBundle] pathForResource:@"skateRunnerCat" ofType:@"jpg"];
    equipmentCategoryImage = [UIImage imageWithContentsOfFile:imagePath2];
    EquipmentCategory *skateRunner = [model AddNewEquipmentCategory:@"Skate Runner"
                                                            inOrder:50
                                                           withIcon:equipmentCategoryImage
                                                          andEntity:@"SkateRunner"];
    */
    imagePath2 = nil; equipmentCategoryImage = nil;
    imagePath2 = [[NSBundle mainBundle] pathForResource:@"sticksCat" ofType:@"jpg"];
    equipmentCategoryImage = [UIImage imageWithContentsOfFile:imagePath2];
    EquipmentCategory *stick = [model AddNewEquipmentCategory:@"Stick"
                                                       inOrder:60
                                                      withIcon:equipmentCategoryImage
                                                     andEntity:@"Stick"];

    // Save
    [model saveChanges];
    

    //Clean up to supress compiler warnings
    //toMapleLeafs = nil;
    //player1 = nil; player2 = nil; player3 = nil; player4 = nil; player5 = nil; player6 = nil;
    helmet = nil; gloves = nil; skateBoot = nil;
    //skateHolder = nil; skateRunner = nil;
    stick = nil;
    //playerHelmet = nil;
}

#pragma mark - Date

+ (NSDate *) NewDateFromYear:(int)year month:(int)month day:(int)day
{
	NSCalendar *c = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *dc = [[NSDateComponents alloc] init];
	[dc setYear:year];
	[dc setMonth:month];
	[dc setDay:day];
	[dc setHour:0];
	[dc setMinute:0];
	return [c dateFromComponents:dc];
}

+ (NSDate *) NewDateFromYear:(int)year month:(int)month day:(int)day hour:(int)hour min:(int)min
{
	NSCalendar *c = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *dc = [[NSDateComponents alloc] init];
	[dc setYear:year];
	[dc setMonth:month];
	[dc setDay:day];
	[dc setHour:hour];
	[dc setMinute:min];
	return [c dateFromComponents:dc];
}


@end
