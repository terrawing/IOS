//
//  AddHelmet.m
//  Equip
//
//  Created by William Wong on 2014-03-29.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "AddHelmet.h"

@interface AddHelmet ()

@end

@implementation AddHelmet

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
    
    // Must hand-convert NSDate into ISO 8601 format
    // Future versions of this app will include a converter that runs automatically
    NSDateFormatter *isoDate = [[NSDateFormatter alloc] init];
    [isoDate setDateFormat:@"yyyy-MM-dd'T'hh:mm"];
    NSString *dateAssigned = [isoDate stringFromDate:[NSDate date]];
    NSString *dateReleased = [isoDate stringFromDate:[self.releaseDate date]];
    
    NSString *name = [NSString stringWithFormat:@"%@ %@", self.brand.text, self.modelCode.text];
    
    /*
    NSDictionary *d = @{@"Name":name, @"Model":self.modelCode.text, @"Cost":[NSNumber numberWithDouble:143.99], @"ReleaseDate":dateReleased, @"RetireDate":dateAssigned, @"BrandId":[NSNumber numberWithInt:1], @"ManufacturerId":[NSNumber numberWithInt:1], @"Size":[NSNumber numberWithInt:[self.size.text intValue]], @"Color":self.colour.text};
    
    */
    
    NSDictionary *d = @{@"Name":name, @"Model":self.modelCode.text, @"Cost":[NSNumber numberWithDouble:143.99], @"ReleaseDate":dateReleased, @"RetireDate":dateAssigned, @"Brand":self.brand.text, @"Manufacturer":self.manufacturer.text, @"Size":[NSNumber numberWithInt:[self.size.text intValue]], @"Color":self.colour.text};
    
    // Call the delegate, pass in nil
    [self.delegate AddHelmetController:self didEditItem:d];

}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self.delegate AddHelmetController:self didEditItem:nil];
}
@end
