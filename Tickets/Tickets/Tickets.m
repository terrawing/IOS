//
//  Tickets.m
//  Air Seneca
//
//  Created by William Wong on 2014-01-28.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import "Tickets.h"

@interface Tickets ()

@end

@implementation Tickets

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.model generatePickerRowsForFlight:self.flightSelector.selectedSegmentIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)flightNumberChanged:(UISegmentedControl *)sender { //this runs when the flight is changed, reload the picker view
    [self.model generatePickerRowsForFlight:self.flightSelector.selectedSegmentIndex];
    [self.ticketSelector reloadAllComponents];
    [self.ticketSelector selectRow:0 inComponent:0 animated:YES];
}

- (IBAction)buyTickets:(UIButton *)sender {
    NSString *city;
    
    //get the selected row in picker view. ALSO TO GET THE NUMBER OF TICKETS
    int selectedRow = [self.ticketSelector selectedRowInComponent:0];
    
    //get the value from the pickerRow model object array
    NSString *pickerRow = [self.model.pickerRows objectAtIndex:selectedRow];
    
    int segIndex = self.flightSelector.selectedSegmentIndex; //need to know the flight number
    switch(segIndex)
    {
        case 0:
        {
            city = @"OTT";
        }
            break;
            
        case 1:
        {
            city = @"MTL";
        }
            break;
            
        case 2:
        {
            city = @"NYC";
        }
            break;
            
        default:
        {
            city = @"WDC";
        }
            break;
    }
    
    int seatsLeft = [[self.model.seatsAvailable objectAtIndex:segIndex] intValue];
    
    if(seatsLeft > 0) {
        self.buyResultMessage.text = [NSString stringWithFormat:@"Sold %@: %@", city, pickerRow];
        
        //"Buying" the ticket
        [self.model buyTickets:selectedRow onFlight:segIndex withMessage:[NSString stringWithFormat:@"Sold %@: %@", city, pickerRow]];
    }
    else {
        self.buyResultMessage.text = @"Tickets Sold Out";
        
        //"Buying" the ticket
        [self.model buyTickets:selectedRow onFlight:segIndex withMessage:[NSString stringWithFormat:@"Tickets Sold Out For %@", city]];
    }

    [self.model generatePickerRowsForFlight:segIndex];
    
    [self.ticketSelector reloadAllComponents];
    [self.ticketSelector selectRow:0 inComponent:0 animated:YES];
}

#pragma mark - Reset and first launch method

- (void)viewWillAppear:(BOOL)animated { //will be called by the runtime just before the view appears on the screen
    [super viewWillAppear:animated];
    
    if([self.model.purchaseHistory length] == 0) { //APP has been launched for the first time or reset button was pressed
        
        //re-generate the picker view data source
        [self.model generatePickerRowsForFlight:self.flightSelector.selectedSegmentIndex];
        
        //reload all components in the picker view
        [self.ticketSelector reloadAllComponents];
        [self.ticketSelector selectRow:0 inComponent:0 animated:YES];
        
    }
}

#pragma mark - Delegate methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView { //how many spinning wheels do you have
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component { //how many rolls will you have in the wheel
    //return different array statements if there are more than 1 componen ts
    return [self.model.pickerRows count]; //the size of the array
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component { //what does the row say?
    //component value is the component number, so if you have 2 components, it will be 0, 1 ..etc
    
    return [[self.model.pickerRows objectAtIndex:row] description];
}

//figure out what happens when user make selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //NSLog(@"\n%@", [[self.model.pickerRows objectAtIndex:row] description]);
    self.highlightedTicket.text = [[self.model.pickerRows objectAtIndex:row] description];
    
}
@end
