//
//  Tickets.h
//  Air Seneca
//
//  Created by William Wong on 2014-01-28.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface Tickets : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) Model *model;

@property (weak, nonatomic) IBOutlet UISegmentedControl *flightSelector;
@property (weak, nonatomic) IBOutlet UIPickerView *ticketSelector;
@property (weak, nonatomic) IBOutlet UILabel *highlightedTicket;
@property (weak, nonatomic) IBOutlet UILabel *buyResultMessage;

- (IBAction)flightNumberChanged:(UISegmentedControl *)sender;
- (IBAction)buyTickets:(UIButton *)sender;

- (void)viewWillAppear:(BOOL)animated;

@end
