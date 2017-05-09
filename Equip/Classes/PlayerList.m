//
//  PlayerList.m
//
//  Data source is a fetched results controller
//
//  Created by Peter McIntyre on 2012/10/05.
//  Copyright (c) 2012 Seneca College. All rights reserved.
//

#import "PlayerList.h"
#import "PlayerView.h"
#import "EquipmentCategoryList.h"

@interface PlayerList ()
{
    // Not necessary, but it's nice - why?
    // It shortens the reference to the fetched results controller
    // from "self.model.frc_album" to "_frc"
    NSFetchedResultsController *_frc;
}

- (void)updateUI:(NSNotification *)notification;

@end

@implementation PlayerList {}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Increase the table cell height
    //self.tableView.rowHeight = 60.0f;
    
    // Register for a notification
    // Change "ObjectName" to the class name of the object that sent the notification
    // Change "MethodName" to the method name in the object above
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlayerListUI:) name:@"PlayerList_updatePlayerListUI_fetch_completed" object:nil];
    
    // Configure and load the fetched results controller (frc)
    
    // Edit the following statement to set/configure the frc you want to use
    _frc = self.model.frc_players;
    
    // This controller with be the frc delegate
    _frc.delegate = self;
    // No predicate (which means the results will NOT be filtered)
    _frc.fetchRequest.predicate = nil;
    
    // Create an error object
    NSError *error = nil;
    // Perform fetch, and if there's an error, log it
    if (![_frc performFetch:&error]) { NSLog(@"%@", [error description]); }
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)updatePlayerListUI:(NSNotification *)notification
{
    // This method is called when there's new/updated data from the network
    [self.tableView reloadData];
}

#pragma mark - Notification handlers

- (void)updateUI:(NSNotification *)notification
{
    // This method is called when there's new/updated data from the network
    [self.tableView reloadData];
}

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
    Player *o = [_frc objectAtIndexPath:indexPath];
    
    // Set the cell's text label
    cell.textLabel.text = o.lastName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", o.lastName, o.givenNames];
    
    // Set the cell image
    cell.imageView.image = [o.photoHeadshot scaleToSize:CGSizeMake(40.0f, 60.0f)];
    
    return cell;
}

#pragma mark - Segue Method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toPlayerView"])
    {
        // Fetch the selected object
        //sender is used for the detail disclosure button
        Player *o = [_frc objectAtIndexPath:sender];

        // Configure the next view + controller
        PlayerView *nextVC = (PlayerView *)segue.destinationViewController;
        
        nextVC.title = [NSString stringWithFormat:@"%@, %@", o.lastName, o.givenNames];
        nextVC.model = self.model;
        nextVC.o = o;
    }
    
    if ([segue.identifier isEqualToString:@"toEquipmentCategory"])
    {
        //Fetch the selected object
        //self.tableView indexPathForSelectedRow is used for the entire row tap
        Player *o = [_frc objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        
        // Configure the next view + controller
        EquipmentCategoryList *nextVC = (EquipmentCategoryList *)segue.destinationViewController;
        
        nextVC.title = @"Equipment Category";
        nextVC.model = self.model;
        nextVC.o = o;
    }
    
    if ([segue.identifier isEqualToString:@"toAddPlayer"])
    {
        Player *p;
        
        // Configure the next view + controller
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        AddPlayer *nextVC = (AddPlayer *)nav.topViewController;
        
        nextVC.title = @"Add Player";
        nextVC.model = self.model;
        nextVC.player = p;
        nextVC.delegate = self; //MUST PASS THE DELEGATE TO THE CONTROLLER
    }
}

#pragma mark - Handler for Detail disclosure tapping

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toPlayerView" sender:indexPath];
}

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
    // Dismiss the modal view controller
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
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
