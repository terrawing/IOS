//
//  AddGloves.m
//  Equip
//
//  Created by William Wong on 2014-04-07.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "AddGloves.h"

@interface AddGloves ()

@end

@implementation AddGloves

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Dismiss the keyboard when clicking somwhere else besides the username/pass textfield
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

}

-(void)dismissKeyboard {
    [self.manufacturer resignFirstResponder];
    [self.brand resignFirstResponder];
    [self.modelCode resignFirstResponder];
    [self.size resignFirstResponder];
    [self.colour resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)datePicker:(UIDatePicker *)sender {
}

- (IBAction)save:(UIBarButtonItem *)sender {
    // Dismiss the keyboard
    [self.view endEditing:NO];
    
    if (self.manufacturer.text.length == 0)
    {
        self.manufacturer.placeholder = @"REQUIRED - Manufacturer";
        return;
    }
    
    if (self.brand.text.length == 0)
    {
        self.brand.placeholder = @"REQUIRED - Brand";
        return;
    }
    
    if (self.modelCode.text.length == 0)
    {
        self.modelCode.placeholder = @"REQUIRED - Model Code";
        return;
    }
    
    if (self.colour.text.length == 0)
    {
        self.colour.placeholder = @"REQUIRED - Colour";
        return;
    }
    
    if (self.size.text.length == 0)
    {
        self.size.placeholder = @"REQUIRED - Size";
        return;
    }
    
    NSDateFormatter *isoDate = [[NSDateFormatter alloc] init];
    [isoDate setDateFormat:@"yyyy-MM-dd'T'hh:mm"];
    NSString *dateAssigned = [isoDate stringFromDate:[NSDate date]];
    NSString *dateReleased = [isoDate stringFromDate:[self.releaseDate date]];
    
    NSString *name = [NSString stringWithFormat:@"%@ %@", self.brand.text, self.modelCode.text];
    
    NSDictionary *d = @{@"Name":name, @"Model":self.modelCode.text, @"Cost":[NSNumber numberWithDouble:62.59], @"ReleaseDate":dateReleased, @"RetireDate":dateAssigned, @"Brand":self.brand.text, @"Manufacturer":self.manufacturer.text, @"Size":[NSNumber numberWithInt:[self.size.text intValue]], @"Color":self.colour.text};
    
    // Call the delegate, pass in nil
    [self.delegate AddGlovesController:self didEditItem:d];

}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self.delegate AddGlovesController:self didEditItem:nil];
}
@end
