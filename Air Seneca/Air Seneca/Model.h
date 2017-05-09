//
//  Model.h
//  Air Seneca
//
//  Created by William Wong on 2014-01-28.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic, strong) NSArray *ticketCost;

@property (nonatomic, strong) NSMutableArray *seatsAvailable; //not fixed, array can be changed

@property (nonatomic, strong) NSMutableArray *pickerRows;

- (void)buyTickets:(int)numberOfTickets onFlight:(int)flightNumber;

- (void)generatePickerRowsForFlight:(int)flightNumber;

@end
