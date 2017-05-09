//
//  Model.m
//  Air Seneca
//
//  Created by William Wong on 2014-01-28.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import "Model.h"

//private
@interface Model () {
    //View controllers don't need to see the file system, no point making them public
    
    NSURL *_documentsDirectory; //file system URL to the app's "documents" directory
    NSURL *_dataFile; //file system URL to a data file that's located in that directory
}
@end

//public
@implementation Model

- (id)init {
    if(self = [super init]) {
        //Get a reference to the file system
        NSFileManager *fs = [[NSFileManager alloc] init];
        
        //URL to Documents directory
        _documentsDirectory = [[fs URLsForDirectory:NSDocumentationDirectory inDomains:NSUserDomainMask] firstObject];
        
        //URL to a data file named 'TicketsAppData.plist' in that directory. Writing data to the plist file as well
        _dataFile = [_documentsDirectory URLByAppendingPathComponent:@"TicketsAppData.plist"];
        
        //declare the variable to store the total seats available
        _seatsAvailable = [[NSMutableArray alloc] init];
        
        //Check for persisted data
        if([fs fileExistsAtPath:[_dataFile path]]) { //If file exists
            
            //read and use the data
            NSDictionary *savedData = [NSDictionary dictionaryWithContentsOfURL:_dataFile];
            
            //Seats Available
            _seatsAvailable = [savedData objectForKey:@"seatsAvailable"];
            
            //Purchase History
            self.purchaseHistory = [savedData objectForKey:@"purchaseHistory"];
            
        }
        else { //If file does not exist, so have to initialize the seats available from scratch (APP is launched for the first time/ reseted)
            for(int i = 0; i < 4; i++) {
                [_seatsAvailable addObject:[NSNumber numberWithInt:40]];
            }

        }
        
        //declare the set costs for the tickets
        _ticketCost = @[
                        [NSNumber numberWithDouble:110.50],
                         [NSNumber numberWithDouble:112.70],
                         [NSNumber numberWithDouble:147.35],
                         [NSNumber numberWithDouble:168.25]
                         ];
        
        //An array that is dynamically changable to store the picker view strings
        _pickerRows = [[NSMutableArray alloc] init];
        
        //So the view won't show a "(null)" on the screen when prepending the string
        _purchaseHistory = @"";
    }
    
    return self;
}

- (void)buyTickets:(int)numberOfTickets onFlight:(int)flightNumber withMessage:(NSString *)buyMessage {
    int currentNumSeats = 0; //doesn't matter if I assign it a not. Just to make sure I don't have an undefined
    
    switch(flightNumber) {
            
        case 0: //OTT
        {
            //get element number 1 and convert it to an int value for calculations
            currentNumSeats = [[self.seatsAvailable objectAtIndex:0] intValue];
            
            //Subtract the number of tickets with the current number of seats available
            currentNumSeats -= numberOfTickets;
            
            //Box the current number of seats as a NSNumber to be used for the NSMutable array
            NSNumber *num0 = [NSNumber numberWithInt:currentNumSeats];
            
            //update the array's element number 1 with the current number of seats in NSNumber format
            [self.seatsAvailable replaceObjectAtIndex:0 withObject:num0];
        }
            break;
        
        case 1: //MTL
        {
            currentNumSeats = [[self.seatsAvailable objectAtIndex:1] intValue];
            currentNumSeats -= numberOfTickets;
            NSNumber *num1 = [NSNumber numberWithInt:currentNumSeats];
            [self.seatsAvailable replaceObjectAtIndex:1 withObject:num1];
        }
            break;
        
        case 2: //NYC
        {
            currentNumSeats = [[self.seatsAvailable objectAtIndex:2] intValue];
            currentNumSeats -= numberOfTickets;
            NSNumber *num2 = [NSNumber numberWithInt:currentNumSeats];
            [self.seatsAvailable replaceObjectAtIndex:2 withObject:num2];
        }
            break;
            
        default: //segment 3 - WDC
        {
            currentNumSeats = [[self.seatsAvailable objectAtIndex:3] intValue];
            currentNumSeats -= numberOfTickets;
            NSNumber *num3 = [NSNumber numberWithInt:currentNumSeats];
            [self.seatsAvailable replaceObjectAtIndex:3 withObject:num3];
            //NSLog(@"\n%@", [self.seatsAvailable description]);
        }
            break;
            
    }//switch
    
    //update the purchaseHistory string by prepending the incoming buyMessage string to the existing purchaseHistory string
    self.purchaseHistory = [NSString stringWithFormat:@"%@\n\n%@\n\n", buyMessage, self.purchaseHistory];
    
    //Create a new NSDictionary Object with 2 key value pairs
    NSDictionary *seatsPurchased = @{@"purchaseHistory": self.purchaseHistory, @"seatsAvailable": self.seatsAvailable};
    
    //persist the data to _dataFile URL
    (void)[seatsPurchased writeToURL:_dataFile atomically:YES];
}

- (void)generatePickerRowsForFlight:(int)flightNumber {
    //the pickerRow can only store the prices of 1 flight number at a time, so it will re-generate a new one everytime
    [self.pickerRows removeAllObjects]; //remove the existing objects in the pickerRows array
    
    double currentCosts = 0.00;
    int currentNumSeats = 0;
    
    switch(flightNumber) {
        case 0:
        {
            currentCosts = [[self.ticketCost objectAtIndex:0] doubleValue];
            currentNumSeats = [[self.seatsAvailable objectAtIndex:0] intValue];
            
            for(int i = 0; i <= currentNumSeats; i++) {
                [self.pickerRows addObject:[NSString stringWithFormat:@"%d x $%1.2f = $%1.2f", i, currentCosts, (i * currentCosts)]];
            }
        }
            break;
            
        case 1:
        {
            currentCosts = [[self.ticketCost objectAtIndex:1] doubleValue];
            currentNumSeats = [[self.seatsAvailable objectAtIndex:1] intValue];
            
            for(int i = 0; i <= currentNumSeats; i++) {
                [self.pickerRows addObject:[NSString stringWithFormat:@"%d x $%1.2f = $%1.2f", i, currentCosts, (i * currentCosts)]];
            }
        }
            break;
            
        case 2:
        {
            currentCosts = [[self.ticketCost objectAtIndex:2] doubleValue];
            currentNumSeats = [[self.seatsAvailable objectAtIndex:2] intValue];
            
            for(int i = 0; i <= currentNumSeats; i++) {
                [self.pickerRows addObject:[NSString stringWithFormat:@"%d x $%1.2f = $%1.2f", i, currentCosts, (i * currentCosts)]];
            }
        }
            break;
            
        default:
        {
            currentCosts = [[self.ticketCost objectAtIndex:3] doubleValue];
            currentNumSeats = [[self.seatsAvailable objectAtIndex:3] intValue];
            
            for(int i = 0; i <= currentNumSeats; i++) {
                [self.pickerRows addObject:[NSString stringWithFormat:@"%d x $%1.2f = $%1.2f", i, currentCosts, (i * currentCosts)]];
            }
        }
            break;
    }
    
}

- (void)resetAppData {
    //get a reference to the file system manager
    NSFileManager *fs = [[NSFileManager alloc] init];
    
    //remove the TicketsAppData.plist file
    [fs removeItemAtURL:_dataFile error:nil];
    
    //Remove all objects from the seatAvailable array
    [_seatsAvailable removeAllObjects];
    
    //repopulate the seatsAvailable with the default numbers for all flights
    for(int i = 0; i < 4; i++) {
        [_seatsAvailable addObject:[NSNumber numberWithInt:40]];
    }
    
    self.purchaseHistory = @"";
}

@end
