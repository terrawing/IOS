//
//  Reset.m
//  Tickets
//
//  Created by William Wong on 2014-02-09.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import "Reset.h"

@interface Reset ()

@end

@implementation Reset

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super init]) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Interaction

- (IBAction)alertReset:(UIButton *)sender {
    //create and show the alert popup, cancel is buttonIndex 0 and the other button index is 1 and on...
    UIAlertView *myAlert = [[UIAlertView alloc]
                            initWithTitle:@"Reset the ticket values?"
                            message:@"Please choose to reset or cancel."
                            delegate:self
                            cancelButtonTitle:@"Cancel"
                            otherButtonTitles:@"Reset", nil];
    
    //show the alert in the view
    [myAlert show];
}

#pragma mark - Delegate Alert Method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //this method is used to implement what the app should do when a button is pressed in the alert
    
    //buttonIndex == 0 is for cancel and it will do nothing
    
    if(buttonIndex == 1) //reset
    {
        self.resetResult.text = @"All Ticket Values Have Been Reseted.";
        
        //call the model resetAppData method
        [self.model resetAppData];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    //Label text message will not be visible and blank when the user switches tabs then returns to the reset tab
    self.resetResult.text = @"";
}

@end
