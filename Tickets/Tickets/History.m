//
//  History.m
//  Tickets
//
//  Created by William Wong on 2014-02-09.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import "History.h"

@interface History ()

@end

@implementation History

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

- (void)viewWillAppear:(BOOL)animated {
    //Always call the superclass version of the method before your custom implementation code
    [super viewWillAppear:animated];
    
    //Set the text view's text to the model's purchase history string
    self.purchaseHistory.text = self.model.purchaseHistory;
}

@end
