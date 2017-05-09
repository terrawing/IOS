//
//  SkatesList.m
//  Equip
//
//  Created by William Wong on 2014-04-09.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "SkatesList.h"
#import "WebServiceRequest.h"
#import "AddSkates.h"
#import "SkatesDetailNetworkView.h"

@interface SkatesList ()
{
    NSArray *_arr; //array to store the fetched results from webservice because local data returns a fetch result controller or fetch request
}

@end

@implementation SkatesList

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:@"SkatesList_updateUI_fetch_completed" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gwGetAll:) name:@"Model_skatesGetAll_fetch_completed" object:nil];
    _arr = self.model.skatesGetAll;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gwAddNewItem:) name:@"Model_editedGwItem_fetch_completed" object:nil];
}

#pragma mark - Notification handlers - Get WebService (GET/ADD)

- (void)updateUI:(NSNotification *)notification
{
    // This method is called when there's new/updated data from the network
    [self.tableView reloadData];
}

- (void)gwGetAll:(NSNotification *)notification
{
    // This method is called when there's new/updated data from the network
    
    _arr = self.model.skatesGetAll;
    [self.tableView reloadData];
}

- (void)gwAddNewItem:(NSNotification *)notification
{
    // This method is called when there's new/updated data from the network
    NSLog(@"\nAddNewItem Notification:\n%@", [self.model.editedGwItem description]);
    
    [self.model gwGetAllRefresh:@"skates" andPropertyName:@"skatesGetAll"];
    return;
    /*
     self.model.gwGetAll = nil;
     (void)[self.model gwGetAll];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate methods

- (void)AddSkatesController:(id)controller didEditItem:(id)item
{
    // Add a new object to the web services, only if an object was passed in
    // Can perform additional business logic and validation here too
    if (item)
    {
        [self.model addNewEquipmentItem:(NSDictionary *)item andEquipmentName:@"skates"];
    }
    
    // Dismiss the modal view controller
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    // Fetch the object from the backing store
    NSDictionary *o = _arr[indexPath.row];
    
    cell.textLabel.text = o[@"Name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Fetch the object from the array results
    //NSDictionary *selectedObject = [_arr objectAtIndex:indexPath.row];
    NSDictionary *selectedObject = _arr[indexPath.row];
    
    // Call the delegate method
    [self.delegate itemSelectorController:self didSelectItem:selectedObject];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toAddSkates"])
    {
        // Configure the next view + controller
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        AddSkates *nextVC = (AddSkates *)nav.topViewController;
        
        nextVC.model = self.model;
        nextVC.delegate = self;
    }
    
    if([segue.identifier isEqualToString:@"toSkatesDetailNetworkView"])
    {
        
        //sender is used for the detail disclosure button
        // Fetch the object from the backing store
        NSIndexPath *path = (NSIndexPath *)sender;
        NSDictionary *o = _arr[path.row];
        
        // Configure the next view + controller
        SkatesDetailNetworkView *nextVC = (SkatesDetailNetworkView *)segue.destinationViewController;
        
        nextVC.title = [NSString stringWithFormat:@"%@ %@", o[@"Brand"], o[@"Model"]];
        nextVC.model = self.model;
        nextVC.skatesDictionary = o;
    }
}

#pragma mark - Handler for Detail disclosure tapping

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toSkatesDetailNetworkView" sender:indexPath];
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self.delegate itemSelectorController:self didSelectItem:nil];
}

@end
