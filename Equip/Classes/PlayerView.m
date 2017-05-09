//
//  EntityView.m
//
//  Data source is a custom NSManagedObject subclass
//
//  Created by Peter McIntyre on 2012/10/05.
//  Copyright (c) 2012 Seneca College. All rights reserved.
//

#import "PlayerView.h"

@interface PlayerView ()


@end

@implementation PlayerView {}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the user interface
    self.lastName.text = self.o.lastName;
    self.giveName.text = self.o.givenNames;
    self.position.text = self.o.position;
    self.playingStatus.text = self.o.playingStatus;
    self.jerseyNumber.text = [NSString stringWithFormat:@"%@", self.o.jerseyNumber];
    self.height.text = [NSString stringWithFormat:@"%@ in.", self.o.height];
    self.weight.text = [NSString stringWithFormat:@"%@ lbs", self.o.weight];
    self.handedness.text = self.o.handedness;
    
    self.dateofBirth.text = [NSString stringWithFormat:@"%@", [NSDateFormatter localizedStringFromDate:self.o.birthDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle]];
    
    self.playerImage.image = [self.o.photoHeadshot scaleToSize:CGSizeMake(120.0f, 180.0f)];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
- (void)viewWillAppear:(BOOL)animated { //When an edit is made, refresh the UIView controller
    [super viewWillAppear:animated];
    
    
}
*/

#pragma mark - Delegate methods

- (void)AddPlayerController:(id)controller didEditItem:(id)item
{
    // Add a new object to the store, only if an object was passed in
    // Can perform additional business logic and validation here too
    if (item)
    {
        NSDictionary *d = (NSDictionary *)item;
        
        [self.model addNewPlayer:d]; // Add the items by manager class method passing a NSDictionary obj
        
        [self.model saveChanges];
    }
    else //edit mode, go back to playerview controller
    {
        // Load the user interface
        self.lastName.text = self.o.lastName;
        self.giveName.text = self.o.givenNames;
        self.position.text = self.o.position;
        self.playingStatus.text = self.o.playingStatus;
        self.jerseyNumber.text = [NSString stringWithFormat:@"%@", self.o.jerseyNumber];
        self.height.text = [NSString stringWithFormat:@"%@ in.", self.o.height];
        self.weight.text = [NSString stringWithFormat:@"%@ lbs", self.o.weight];
        self.handedness.text = self.o.handedness;
        
        self.dateofBirth.text = [NSString stringWithFormat:@"%@", [NSDateFormatter localizedStringFromDate:self.o.birthDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle]];
        
        self.playerImage.image = [self.o.photoHeadshot scaleToSize:CGSizeMake(120.0f, 180.0f)];
    }
    // Dismiss the modal view controller
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - Segue Method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toEditPlayer"])
    {
        // Fetch the selected object
        //sender is used for the detail disclosure button
        Player *o = self.o;
        
        // Configure the next view + controller
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        AddPlayer *nextVC = (AddPlayer *)nav.topViewController;
        
        nextVC.title = @"Edit Player";
        nextVC.model = self.model;
        nextVC.player = o;
        nextVC.delegate = self; //MUST PASS THE DELEGATE TO THE CONTROLLER
    }
}

- (void)viewDidUnload {
    [self setLastName:nil];
    [self setGiveName:nil];
    [self setPosition:nil];
    [self setPlayingStatus:nil];
    [self setJerseyNumber:nil];
    [self setHeight:nil];
    [self setWeight:nil];
    [self setHandedness:nil];
    [self setDateofBirth:nil];
    [self setPlayerImage:nil];
    [super viewDidUnload];
}

@end
