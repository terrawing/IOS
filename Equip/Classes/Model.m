//
//  Model.m
//
//  Created by Peter McIntyre on 2012/06/22.
//  Copyright (c) 2012 Seneca College. All rights reserved.
//

#import "Model.h"
#import "CDStack.h"
#import "StoreInitializer.h"
#import "ImageToDataTransformer.h"
#import "WebServiceRequest.h"

@interface Model ()
{
    // Core Data stack (private instance variable)
    CDStack *_cdStack;
}

// Private method
- (NSURL *)applicationDocumentsDirectory;

@end

@implementation Model

#pragma mark - Object lifecycle

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Check whether the app is being launched for the first time
        // If yes, check if there's an object store file in the app bundle
        // If yes, copy the object store file to the Documents directory
        // If no, create some new data if you need to
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchedTeamResponse:) name:@"Model_fetchedTeamResponse_fetch_completed" object:nil];
        
        // URL to the object store file in the app bundle
        NSURL *storeFileInBundle = [[NSBundle mainBundle] URLForResource:@"ObjectStore" withExtension:@"sqlite"];
        
        // URL to the object store file in the Documents directory
        NSURL *storeFileInDocumentsDirectory = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ObjectStore.sqlite"];
        
        // System file manager
        NSFileManager *fs = [[NSFileManager alloc] init];
        
        // Check whether this is the first launch of the app
        BOOL isFirstLaunch = ![fs fileExistsAtPath:[storeFileInDocumentsDirectory path]];
        
        // Check whether the app is supplied with starter data in the app bundle
        BOOL hasStarterData = [fs fileExistsAtPath:[storeFileInBundle path]];
        
        if (isFirstLaunch) 
        {
            if (hasStarterData) 
            {
                // Use the supplied starter data
                [fs copyItemAtURL:storeFileInBundle toURL:storeFileInDocumentsDirectory error:nil];
                // Create a Core Data stack object after copying file
                _cdStack = [[CDStack alloc] init];
            }
            else 
            {
                // Create a Core Data stack object before creating new data
                _cdStack = [[CDStack alloc] init];
                // Create some new data
                [StoreInitializer create:self];
            }
        }
        else 
        {
            _cdStack = [[CDStack alloc] init];
        }
    }
    return self;
}

#pragma mark - Date

- (NSDate *) NewDateFromYear:(int)year month:(int)month day:(int)day
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

#pragma mark - Get requests for team

- (void)fetchedTeamResponse:(NSNotification *)notification
{
    if(self.fr_team) {
        //Check if there is a team object core data existing already. This notification will always fired, so to prevent a new team object added again and players added again. Do this
        return;
    }
    else
    {
        //Get the current year, month, day, hour and minute
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy"];
        int year = [[DateFormatter stringFromDate:[NSDate date]] intValue];
        [DateFormatter setDateFormat:@"MM"];
        int month = [[DateFormatter stringFromDate:[NSDate date]] intValue];
        [DateFormatter setDateFormat:@"dd"];
        int day = [[DateFormatter stringFromDate:[NSDate date]] intValue];
    
        //save the fetched data to local store
        Team *team = [self addNewTeam:self.fetchedTeam[@"City"] withTeamName:self.fetchedTeam[@"Name"] withEquipMan:self.fetchedTeam[@"EMName"] withUserName:self.fetchedTeam[@"EMUsername"] withPassword:@"passw[]rd" aLoginToken:self.authToken andLoginTime:[self NewDateFromYear:year month:month day:day] alsoWSObject:[self.fetchedTeam[@"Id"] intValue]];
    
        NSLog(@"\nThis is the team object saved to store:\n\n%@", [team description]);
    
        [self saveChanges];
        
        if(team) {
            //fetch the players from webservice
            [self fetchedPlayersRequest:self.fetchedTeam[@"Id"]];
        }
    }
}

- (void)fetchTeamRequest:(NSString *)uname
{
    WebServiceRequest *getTeam = [[WebServiceRequest alloc] init];
    
    getTeam.urlBase = @"http://equipservices.azurewebsites.net";
    
    NSString *requestURL = [NSString stringWithFormat:@"/api/teams?managerusername=%@", uname];
    
    [getTeam sendRequestToUrlPath:requestURL forDataKeyName:@"Item" from:self propertyNamed:@"fetchedTeam"];
    
    //NSLog(@"This is fetched team: \n%@", [self.fetchedTeam description]);
    
    // Register for a notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchedTeamResponse:) name:@"Model_fetchedTeam_fetch_completed" object:nil];
}

#pragma mark - Get requests for players

- (void)fetchedPlayersResponse:(NSNotification *)notification
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"PKessel" ofType:@"jpg"];
    UIImage *playerImage = [UIImage imageWithContentsOfFile:imagePath];
    
    // Store the player objects by looping the array
    for (int i = 0; i < [self.fetchedPlayers count]; i++)
    {
        NSDictionary *o = [self.fetchedPlayers objectAtIndex:i];
        NSString *pos = @"";
        
        if([o[@"IcePosition"] isEqualToString:@"G"])
            pos = @"Goaltender";
        else if([o[@"IcePosition"] isEqualToString:@"D"])
            pos = @"Defenceman";
        else if([o[@"IcePosition"] isEqualToString:@"RW"])
            pos = @"Right Wing";
        else if([o[@"IcePosition"] isEqualToString:@"LW"])
            pos = @"Left Wing";
        else if([o[@"IcePosition"] isEqualToString:@"F"])
            pos = @"Forward";
        else
            pos = @"Centre";
        
        NSString *date = [o[@"DateOfBirth"] description];
        int year = [[date substringToIndex:4] intValue];
        int month = [[date substringWithRange:NSMakeRange(5, 2)] intValue];
        int day = [[date substringWithRange:NSMakeRange(8, 2)] intValue];
        
        Player *player = [self addNewPlayer:o[@"FamilyName"] withGiveName:o[@"GivenNames"] withImage:playerImage hasJerseyNum:[o[@"JerseyNumber"] intValue] playsPosition:pos withHand:o[@"Handedness"] haveStatus:@"Active" bornedOn:[self NewDateFromYear:year month:month day:day] withHeight:[o[@"Height"] intValue] withWeight:[o[@"Weight"] intValue]];
        
        [self saveChanges];
        player = nil;
    }
}

- (void)fetchedPlayersRequest:(NSString *)wsObjId
{
    WebServiceRequest *getPlayers = [[WebServiceRequest alloc] init];
    
    getPlayers.urlBase = @"http://equipservices.azurewebsites.net";
    
    NSString *requestUrl = [NSString stringWithFormat:@"/api/players?team=%@", wsObjId];
    
    [getPlayers sendRequestToUrlPath:requestUrl forDataKeyName:@"Collection" from:self propertyNamed:@"fetchedPlayers"];
    
    // Register for a notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchedPlayersResponse:) name:@"Model_fetchedPlayers_fetch_completed" object:nil];
}

#pragma mark - Get all requests from web service

// All 'get all' requests
- (NSArray *)helmetsGetAll
{
    if (_helmetsGetAll) { return _helmetsGetAll; }
    
    _helmetsGetAll = [[NSArray alloc] init];
    
    WebServiceRequest *gwGetAll = [[WebServiceRequest alloc] init];
    
    [gwGetAll settingUrlBase:@"http://equipservices.azurewebsites.net"];
    
    [gwGetAll sendRequestToUrlPath:@"/api/helmets" forDataKeyName:@"Collection" from:self propertyNamed:NSStringFromSelector(_cmd)];
    
    return _helmetsGetAll;
}

- (NSArray *)glovesGetAll
{
    if (_glovesGetAll) { return _glovesGetAll; }
    
    _glovesGetAll = [[NSArray alloc] init];
    
    WebServiceRequest *gwGetAll = [[WebServiceRequest alloc] init];
    
    [gwGetAll settingUrlBase:@"http://equipservices.azurewebsites.net"];
    
    [gwGetAll sendRequestToUrlPath:@"/api/gloves" forDataKeyName:@"Collection" from:self propertyNamed:NSStringFromSelector(_cmd)];
    
    return _glovesGetAll;
}

- (NSArray *)sticksGetAll
{
    if (_sticksGetAll) { return _sticksGetAll; }
    
    _sticksGetAll = [[NSArray alloc] init];
    
    WebServiceRequest *gwGetAll = [[WebServiceRequest alloc] init];
    
    [gwGetAll settingUrlBase:@"http://equipservices.azurewebsites.net"];
    
    [gwGetAll sendRequestToUrlPath:@"/api/sticks" forDataKeyName:@"Collection" from:self propertyNamed:NSStringFromSelector(_cmd)];
    
    return _sticksGetAll;
}

- (NSArray *)skatesGetAll
{
    if (_skatesGetAll) { return _skatesGetAll; }
    
    _skatesGetAll = [[NSArray alloc] init];
    
    WebServiceRequest *gwGetAll = [[WebServiceRequest alloc] init];
    
    [gwGetAll settingUrlBase:@"http://equipservices.azurewebsites.net"];
    
    [gwGetAll sendRequestToUrlPath:@"/api/skates" forDataKeyName:@"Collection" from:self propertyNamed:NSStringFromSelector(_cmd)];
    
    return _skatesGetAll;
}

// Refresh
- (void)gwGetAllRefresh:(NSString *)equipmentType andPropertyName:(NSString *)propertyName
{
    WebServiceRequest *gwGetAll = [[WebServiceRequest alloc] init];
    
    [gwGetAll settingUrlBase:@"http://equipservices.azurewebsites.net"];
    
    NSString *sendRequestURL = [NSString stringWithFormat:@"/api/%@", equipmentType];
    
    [gwGetAll sendRequestToUrlPath:sendRequestURL forDataKeyName:@"Collection" from:self propertyNamed:propertyName];
}

// Typical 'add new' request template
- (void)addNewEquipmentItem:(NSDictionary *)newItem andEquipmentName:(NSString *)equipmentType
{
    WebServiceRequest *gwAddNewItem = [[WebServiceRequest alloc] init];
    
    [gwAddNewItem settingUrlBase:@"http://equipservices.azurewebsites.net"];
    
    gwAddNewItem.httpMethod = @"POST";
    gwAddNewItem.messageBody = newItem;
    
    NSLog(@"\naddNewItem dictionary being sent...\n%@", [newItem description]);
    
    NSString *sendRequestURL = [NSString stringWithFormat:@"/api/%@?usingNames", equipmentType];
    
    [gwAddNewItem sendRequestToUrlPath:sendRequestURL forDataKeyName:@"Item" from:self propertyNamed:@"editedGwItem"];
}


#pragma mark - Data from the network

// This is a custom getter for an array of results from the network
// Use this as a template... copy it, paste it, and then edit it
- (NSArray *)dataFromNetwork
{
    // If the data exists, return it
    if (_dataFromNetwork) { return _dataFromNetwork; }

    // Otherwise, must fetch the data...
    
    // Initialize an empty array
    _dataFromNetwork = [[NSArray alloc] init];

    // Initialize a web service requestor
    WebServiceRequest *getNamedCollection = [[WebServiceRequest alloc] init];
    
    // Execute the web service requestor
    [getNamedCollection sendRequestToUrlPath:@"/path/to/resource" forDataKeyName:@"TopLevelJSONKeyName" from:self propertyNamed:NSStringFromSelector(_cmd)];
    
    return _dataFromNetwork;
}

#pragma mark - Managed object maintenance

// Generic 'add new' method
- (id)addNew:(NSString *)entityName
{
    // Create and return the new managed object
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_cdStack.managedObjectContext];
}

#pragma mark - Add Team

- (Team *)addNewTeam
{
    return (Team *)[self addNew:@"Team"];
}

- (Team *)addNewTeam:(NSString *)city withTeamName:(NSString *)teamName withEquipMan:(NSString *)nameofEM withUserName:(NSString *)username withPassword:(NSString *)password aLoginToken:(NSString *)loginToken andLoginTime:(NSDate *)loginTimestamp alsoWSObject:(int)wsObjectId
{
    // Create a new team; notice the cast
    Team *t = (Team *)[self addNew:@"Team"];
    
    // Strings
    t.city = city;
    t.teamName = teamName;
    t.nameofEM = nameofEM;
    t.username = username;
    t.password = password;
    t.loginToken = loginToken;
    
    // Date
    t.loginTimestamp = loginTimestamp;
    
    // Numbers - Notice that we are using the NSNumber literal syntax
    t.wsObjectId = @(wsObjectId);
    
    return t;
}

#pragma mark - Add Players

- (Player *)addNewPlayer
{
    return (Player *)[self addNew:@"Player"];
}

- (Player *)addNewPlayer:(NSString *)lastName withGiveName:(NSString *)givenNames withImage:(UIImage *)photoHeadshot hasJerseyNum:(int)jerseyNumber playsPosition:(NSString *)position withHand:(NSString *)handedness haveStatus:(NSString *)playingStatus bornedOn:(NSDate *)birthDate withHeight:(int)height withWeight:(int)weight
{
    // Create a new player; notice the cast
    Player *p = (Player *)[self addNew:@"Player"];
    
    // Strings
    p.lastName = lastName;
    p.givenNames = givenNames;
    p.position = position;
    p.handedness = handedness;
    p.playingStatus = playingStatus;
    
    // Date
    p.birthDate = birthDate;
    
    // Numbers - Notice that we are using the NSNumber literal syntax
    p.jerseyNumber = @(jerseyNumber);
    p.height = @(height);
    p.weight = @(weight);
    //t.wsObjectId = @(wsObjectId);
    
    // Image
    p.photoHeadshot = photoHeadshot;
    
    return p;
}

#pragma mark - Add new player by user interaction

- (void)addNewPlayer:(NSDictionary *)pd
{
    // Create a new album; notice the cast
    Player *p = (Player *)[self addNew:@"Player"];
    
    // Strings
    p.lastName = pd[@"lastName"];
    p.givenNames = pd[@"givenNames"];
    p.photoHeadshot = pd[@"photoHeadshot"];
    p.jerseyNumber = pd[@"jerseyNumber"];
    p.position = pd[@"position"];
    p.handedness = pd[@"handedness"];
    p.playingStatus = pd[@"playingStatus"];
    p.birthDate = pd[@"birthDate"];
    p.height = pd[@"height"];
    p.weight = pd[@"weight"];
}

#pragma mark - Add new helmet to the store by tapping the the HelmetList table view

- (void)AddNewHelmet:(NSDictionary *)pd andPlayer:(Player *)player
{
    // Create a new helmet; notice the cast
    Helmet *p = (Helmet *)[self addNew:@"Helmet"];
    
    // Strings
    p.manufacturer = pd[@"Manufacturer"];
    p.brand = pd[@"Brand"];
    p.modelCode = pd[@"Model"];
    //p.orderCode = @"ABCDEFG";
    p.colour = pd[@"Color"];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"helmetCat" ofType:@"jpg"];
    UIImage *helmetImage = [UIImage imageWithContentsOfFile:imagePath];
    
    p.photo = helmetImage; //If an actual image comes back use that here. Use a default picture for now
    p.size = pd[@"Size"];
    //p.faceProtector = @"7800 Faceprotector";
    //p.chinStrap = @"7900 Chinstrap";
    p.wsObjectId = pd[@"Id"];
    [p addPlayersObject:player];
}

#pragma mark - Add new gloves to the store by tapping the the GlovesList table view

- (void)AddNewGloves:(NSDictionary *)pd andPlayer:(Player *)player
{
    // Create a new gloves; notice the cast
    Gloves *p = (Gloves *)[self addNew:@"Gloves"];
    
    // Strings
    p.manufacturer = pd[@"Manufacturer"];
    p.brand = pd[@"Brand"];
    p.modelCode = pd[@"Model"];
    //p.orderCode = @"ABCDEFG";
    p.colour = pd[@"Color"];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"glovesCat" ofType:@"jpg"];
    UIImage *helmetImage = [UIImage imageWithContentsOfFile:imagePath];
    
    p.photo = helmetImage; //If an actual image comes back use that here. Use a default picture for now
    p.size = pd[@"Size"];
    //p.length =
    p.wsObjectId = pd[@"Id"];
    [p addPlayersObject:player];
}

#pragma mark - Add new stick to the store by tapping the the StickList table view

- (void)AddNewStick:(NSDictionary *)pd andPlayer:(Player *)player
{
    // Create a new gloves; notice the cast
    Stick *p = (Stick *)[self addNew:@"Stick"];
    
    // Strings
    p.manufacturer = pd[@"Manufacturer"];
    p.brand = pd[@"Brand"];
    p.modelCode = pd[@"Model"];
    //p.orderCode = @"ABCDEFG";
    p.colour = pd[@"Color"];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"sticksCat" ofType:@"jpg"];
    UIImage *stickImage = [UIImage imageWithContentsOfFile:imagePath];
    
    p.photo = stickImage; //If an actual image comes back use that here. Use a default picture for now
    
    //p.leftRight = pd[@"LeftRight"];
    p.flex = pd[@"Flex"];
    p.curve = pd[@"Lie"];
    p.wsObjectId = pd[@"Id"];
    [p addPlayersObject:player];
}

#pragma mark - Add new skates to the store by tapping the the StickList table view

- (void)AddNewSkates:(NSDictionary *)pd andPlayer:(Player *)player
{
    // Create a new gloves; notice the cast
    SkateBoot *p = (SkateBoot *)[self addNew:@"SkateBoot"];
    
    // Strings
    p.manufacturer = pd[@"Manufacturer"];
    p.brand = pd[@"Brand"];
    p.modelCode = pd[@"Model"];
    //p.orderCode = @"ABCDEFG";
    p.colour = pd[@"Color"];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"skatesCat" ofType:@"jpg"];
    UIImage *skatesImage = [UIImage imageWithContentsOfFile:imagePath];
    
    p.photo = skatesImage; //If an actual image comes back use that here. Use a default picture for now
    
    p.size = pd[@"Size"];
    p.stiffness = pd[@"HollowRadius"];
    p.width = [pd[@"BladeLength"] stringValue];
    p.wsObjectId = pd[@"Id"];
    [p addPlayersObject:player];
}


#pragma mark - Add Equipment Category

- (EquipmentCategory *)AddNewEquipmentCategory
{
    return (EquipmentCategory *)[self addNew:@"EquipmentCategory"];
}

- (EquipmentCategory *)AddNewEquipmentCategory:(NSString *)displayName inOrder:(int)displayOrder withIcon:(UIImage *)displayIcon andEntity:(NSString *)nameOfEntity
{
    // Create a new equipmentcategory; notice the cast
    EquipmentCategory *e = (EquipmentCategory *)[self addNew:@"EquipmentCategory"];
    
    // Strings
    e.displayName = displayName;
    e.nameOfEntity = nameOfEntity;
    
    // Numbers
    e.displayOrder = @(displayOrder);
    
    // Image
    e.displayIcon = displayIcon;
    
    return e;
}

#pragma mark - Add Helmet

- (Helmet *)AddNewHelmet
{
    return (Helmet *)[self addNew:@"Helmet"];
}

- (Helmet *)AddNewHelmet:(NSString *)manufacturer withBrand:(NSString *)brand withModelCode:(NSString *)modelCode withOrderCode:(NSString *)orderCode withColour:(NSString *)colour withImage:(UIImage *)photo withSize:(int)size withFaceProtector:(NSString *)faceProtector withChinStrap:(NSString *)chinStrap andPlayer:(Player *)player
{
    // Create a new helmet; notice the cast
    Helmet *h = (Helmet *)[self addNew:@"Helmet"];
    
    // Strings
    h.manufacturer = manufacturer;
    h.brand = brand;
    h.modelCode = modelCode;
    h.orderCode = orderCode;
    h.colour = colour;
    h.faceProtector = faceProtector;
    h.chinStrap = chinStrap;
    
    // Numbers
    h.size = @(size);
    
    // Image
    h.photo = photo;
    
    //Add Player object
    [h addPlayersObject:player];
    
    return h;
}

#pragma mark - Add Gloves

- (Gloves *)AddNewGloves
{
    return (Gloves *)[self addNew:@"Gloves"];
}

- (Gloves *)AddNewGloves:(NSString *)manufacturer withBrand:(NSString *)brand withModelCode:(NSString *)modelCode withOrderCode:(NSString *)orderCode withColour:(NSString *)colour withImage:(UIImage *)photo withSize:(int)size withLength:(int)length andPlayer:(Player *)player
{
    // Create a new helmet; notice the cast
    Gloves *g = (Gloves *)[self addNew:@"Gloves"];
    
    // Strings
    g.manufacturer = manufacturer;
    g.brand = brand;
    g.modelCode = modelCode;
    g.orderCode = orderCode;
    g.colour = colour;
    
    // Numbers
    g.size = @(size);
    g.length = @(length);
    
    // Image
    g.photo = photo;
    
    //Add Player object
    [g addPlayersObject:player];
    
    return g;
}

#pragma mark - Add Stick

- (Stick *)AddNewStick;
{
    return (Stick *)[self addNew:@"Stick"];
}

- (Stick *)AddNewStick:(NSString *)manufacturer withBrand:(NSString *)brand withModelCode:(NSString *)modelCode withOrderCode:(NSString *)orderCode withColour:(NSString *)colour withImage:(UIImage *)photo withPattern:(NSString *)pattern withLeftRight:(NSString *)leftRight withCurve:(int)curve withFlex:(int)flex andPlayer:(Player *)player
{
    // Create a new stick; notice the cast
    Stick *s = (Stick *)[self addNew:@"Stick"];
    
    // Strings
    s.manufacturer = manufacturer;
    s.brand = brand;
    s.modelCode = modelCode;
    s.orderCode = orderCode;
    s.colour = colour;
    s.pattern = pattern;
    s.leftRight = leftRight;
    
    // Numbers
    s.curve = @(curve);
    s.flex = @(flex);
    
    // Image
    s.photo = photo;
    
    //Add Player object
    [s addPlayersObject:player];
    
    return s;
}

#pragma mark - Add SkateBoot

- (SkateBoot *)AddNewSkates;
{
    return (SkateBoot *)[self addNew:@"SkateBoot"];
}

- (SkateBoot *)AddNewSkates:(NSString *)manufacturer withBrand:(NSString *)brand withModelCode:(NSString *)modelCode withOrderCode:(NSString *)orderCode withColour:(NSString *)colour withImage:(UIImage *)photo withSize:(int)skateSize withStiffness:(int)stiffness withWidth:(NSString *)width andPlayer:(Player *)player
{
    // Create a new skateboot; notice the cast
    SkateBoot *s = (SkateBoot *)[self addNew:@"SkateBoot"];
    
    // Strings
    s.manufacturer = manufacturer;
    s.brand = brand;
    s.modelCode = modelCode;
    s.orderCode = orderCode;
    s.colour = colour;
    s.width = width;
    
    // Numbers
    s.size = @(skateSize);
    s.stiffness = @(stiffness);
    
    // Image
    s.photo = photo;
    
    //Add Player object
    [s addPlayersObject:player];
    
    return s;
}

#pragma mark - Save changes

- (void)saveChanges
{
    [_cdStack saveContext];
}

#pragma mark - Fetched results controllers

// This is a custom getter for the fetched results controller property
// Use this as a template... copy it, paste it, and then edit it
- (NSFetchedResultsController *)frc_entity
{
    // Inside a custom getter, you must use the underscore-prefixed name (of the instance variable that backs the property)
    
    // If the frc is already configured, simply return it
    if (_frc_entity) { return _frc_entity; }
    
    // Otherwise, create a new frc, and set it as the property (and return it below)
    _frc_entity = [_cdStack frcWithEntityNamed:@"EntityName" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"attributeName,YES" andSectionNameKeyPath:nil];
    
    return _frc_entity;
}

- (NSFetchedResultsController *)frc_players
{
    if (_frc_players) { return _frc_players; }
    
    _frc_players = [_cdStack frcWithEntityNamed:@"Player" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"lastName,YES" andSectionNameKeyPath:nil];
    
    return _frc_players;

}

- (NSFetchedResultsController *)frc_equipment_category
{
    if (_frc_equipment_category) { return _frc_equipment_category; }
    
    _frc_equipment_category = [_cdStack frcWithEntityNamed:@"EquipmentCategory" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"displayOrder,YES" andSectionNameKeyPath:nil];
    
    return _frc_equipment_category;
    
}

#pragma mark - Fetched request for non table controllers

//Using a custom getter
- (Team *)fr_team
{
    if (_fr_team) { return _fr_team; }
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Team"];
    
    //Execute the fetch request
    NSError *error;
    NSArray *results = [_cdStack.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Team fetch error: %@", [error description]);
    }
    
    //Return the result
    return ([results count] == 1) ? [results firstObject] : nil;
}

- (Helmet *)helmetForPlayer:(Player *)player
{
    //Create a new FSFetchRequest object, to query the Helmet Collection
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Helmet"];
    
    //Create a predicate object
    NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%@ in players", player];
    
    //Set/configure the fetch request object w/ this new predicate object
    [fetchRequest setPredicate:predicateString];
    
    //Execute the fetch request
    NSError *error;
    NSArray *results = [_cdStack.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Helmet fetch error: %@", [error description]);
    }
    
    //Return the result
    return ([results count] == 1) ? [results firstObject] : nil;
    
}

- (Gloves *)glovesForPlayer:(Player *)player
{
    //Create a new FSFetchRequest object, to query the Gloves Collection
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Gloves"];
    
    //Create a predicate object
    NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%@ in players", player];
    
    //Set/configure the fetch request object w/ this new predicate object
    [fetchRequest setPredicate:predicateString];
    
    //Execute the fetch request
    NSError *error;
    NSArray *results = [_cdStack.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Gloves fetch error: %@", [error description]);
    }
    
    //Return the result
    return ([results count] == 1) ? [results firstObject] : nil;
}

- (Stick *)stickForPlayer:(Player *)player
{
    //Create a new FSFetchRequest object, to query the Gloves Collection
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Stick"];
    
    //Create a predicate object
    NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%@ in players", player];
    
    //Set/configure the fetch request object w/ this new predicate object
    [fetchRequest setPredicate:predicateString];
    
    //Execute the fetch request
    NSError *error;
    NSArray *results = [_cdStack.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Stick fetch error: %@", [error description]);
    }
    
    //Return the result
    return ([results count] == 1) ? [results firstObject] : nil;
}

- (SkateBoot *)skatesForPlayer:(Player *)player
{
    //Create a new FSFetchRequest object, to query the Gloves Collection
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"SkateBoot"];
    
    //Create a predicate object
    NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%@ in players", player];
    
    //Set/configure the fetch request object w/ this new predicate object
    [fetchRequest setPredicate:predicateString];
    
    //Execute the fetch request
    NSError *error;
    NSArray *results = [_cdStack.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"SkateBoot fetch error: %@", [error description]);
    }
    
    //Return the result
    return ([results count] == 1) ? [results firstObject] : nil;
}


- (NSURL *)applicationDocumentsDirectory
{
    // Get a reference to the file system
    NSFileManager *fs = [[NSFileManager alloc] init];
    
    // URL to documents directory
    return [[fs URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}

@end
