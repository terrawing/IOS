//
//  EquipmentCategoryView.m
//  Equip
//
//  Created by William Wong on 2014-03-16.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "EquipmentCategoryList.h"
#import "HelmetView.h"
#import "GlovesView.h"
#import "StickView.h"
#import "SkatesView.h"

@interface EquipmentCategoryList ()
{
    // Not necessary, but it's nice - why?
    // It shortens the reference to the fetched results controller
    // from "self.model.frc_album" to "_frc"
    NSFetchedResultsController *_frc;
}

//- (void)updateUI:(NSNotification *)notification;

@end

@implementation EquipmentCategoryList {}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Configure and load the fetched results controller (frc)
    
    // Edit the following statement to set/configure the frc you want to use
    _frc = self.model.frc_equipment_category;
    
    // This controller with be the frc delegate
    _frc.delegate = self;
    // No predicate (which means the results will NOT be filtered)
    _frc.fetchRequest.predicate = nil;
    
    // Create an error object
    NSError *error = nil;
    // Perform fetch, and if there's an error, log it
    if (![_frc performFetch:&error]) { NSLog(@"%@", [error description]); }
}

/*
- (void)updateUI:(NSNotification *)notification
{
    // This method is called when there's new/updated data from the network
    [self.tableView reloadData];
}
*/

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // How many sections for the table view?
    return [[_frc sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Get the current section info object from the frc
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_frc sections] objectAtIndex:section];
    // How may objects (rows) are in that section?
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    // Fetch the object that backs the current index path (row)
    EquipmentCategory *o = [_frc objectAtIndexPath:indexPath];
    
    // Set the cell's text label
    cell.textLabel.text = o.displayName;
    
    // Set the cell image
    cell.imageView.image = [o.displayIcon scaleToSize:CGSizeMake(40.0f, 40.0f)];
    
    return cell;
}

#pragma mark - Handle which row the user tap /selected

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get the equipment category object that backs the selected row
    EquipmentCategory *o = [_frc objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
    
    if([o.nameOfEntity isEqualToString:@"Helmet"]) {
        [self performSegueWithIdentifier:@"toHelmetView" sender:indexPath];
    }
    
    if([o.nameOfEntity isEqualToString:@"Gloves"]) {
        [self performSegueWithIdentifier:@"toGlovesView" sender:indexPath];
    }
    
    if([o.nameOfEntity isEqualToString:@"Stick"]) {
        [self performSegueWithIdentifier:@"toStickView" sender:indexPath];
    }
    
    if([o.nameOfEntity isEqualToString:@"SkateBoot"]) {
        [self performSegueWithIdentifier:@"toSkatesView" sender:indexPath];
    }
}

#pragma mark - Segue Method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toHelmetView"])
    {
        // Fetch the selected helmet object by calling the model class method
        Helmet *h = [self.model helmetForPlayer:self.o];
        NSLog(@"Helmet from store:\n %@", [h description]);
        
        // Configure the next view + controller
        HelmetView *nextVC = (HelmetView *)segue.destinationViewController;
        
        nextVC.title = @"Helmet";
        nextVC.model = self.model;
        nextVC.p = self.o; //passing the player object into the helmet view
        nextVC.h = h; //passing the helmet object into the helmet view
    }
    
    if ([segue.identifier isEqualToString:@"toGlovesView"])
    {
        // Fetch the selected object
        //sender is used for the detail disclosure button
        Gloves *g = [self.model glovesForPlayer:self.o];
        
        // Configure the next view + controller
        GlovesView *nextVC = (GlovesView *)segue.destinationViewController;
        
        nextVC.title = @"Gloves";
        nextVC.model = self.model;
        nextVC.p = self.o; //passing the player object into the gloves view
        nextVC.g = g; //passing the gloves object into the gloves view
    }
    
    if ([segue.identifier isEqualToString:@"toStickView"])
    {
        // Fetch the selected object
        //sender is used for the detail disclosure button
        Stick *s = [self.model stickForPlayer:self.o];
        
        // Configure the next view + controller
        StickView *nextVC = (StickView *)segue.destinationViewController;
        
        nextVC.title = @"Stick";
        nextVC.model = self.model;
        nextVC.p = self.o; //passing the player object into the gloves view
        nextVC.s = s; //passing the stick object into the stick view
    }
    
    if ([segue.identifier isEqualToString:@"toSkatesView"])
    {
        // Fetch the selected object
        //sender is used for the detail disclosure button
        SkateBoot *s = [self.model skatesForPlayer:self.o];
        
        // Configure the next view + controller
        SkatesView *nextVC = (SkatesView *)segue.destinationViewController;
        
        nextVC.title = @"Skates";
        nextVC.model = self.model;
        nextVC.p = self.o; //passing the player object into the gloves view
        nextVC.s = s; //passing the stick object into the stick view
    }
}

#pragma mark - Handler for Detail disclosure tapping
/*
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toPlayerView" sender:indexPath];
}
*/

#pragma mark - Table view update methods

// Handle row deletion
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Two ways to think about this...
        // 1. Do the 'delete' task here, or
        // 2. Add a method to the model object to delete the object
        // Either way is fine
        
        // Get a reference to the context
        NSManagedObjectContext *context = [_frc managedObjectContext];
        // Delete the object from the collection
        [context deleteObject:[_frc objectAtIndexPath:indexPath]];
        
        // Attempt to save changes
        NSError *error = nil;
        if (![context save:&error])
        {
            // Many different ways of handling the error
            // Here, we just send a message to the debug console log
            NSLog(@"Error when deleting: %@, %@", error, [error userInfo]);
        }
    }
}

// These three methods will add the new row with a smooth animation
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type)
    {
            // Insert
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
            // Delete
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


@end
