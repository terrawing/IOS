//
//  Model.m
//  Air Seneca
//
//  Created by William Wong on 2014-01-28.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import "Model.h"

@implementation Model

- (id)init {
    if(self = [super init]) {
        
        _ticketCost = @[
                        [NSNumber numberWithDouble:110.50],
                         [NSNumber numberWithDouble:112.70],
                         [NSNumber numberWithDouble:147.35],
                         [NSNumber numberWithDouble:168.25]
                         ];
        
        _seatsAvailable = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < 4; i++) {
            [_seatsAvailable addObject:[NSNumber numberWithInt:40]];
        }
        
        _pickerRows = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)buyTickets:(int)numberOfTickets onFlight:(int)flightNumber {
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
    }
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

@end
