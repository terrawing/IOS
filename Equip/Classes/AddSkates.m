//
//  AddSkates.m
//  Equip
//
//  Created by William Wong on 2014-04-09.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "AddSkates.h"

@interface AddSkates ()

@end

@implementation AddSkates

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

- (void)dismissKeyboard {
    [self.manufacturer resignFirstResponder];
    [self.brand resignFirstResponder];
    [self.modelCode resignFirstResponder];
    [self.skateSize resignFirstResponder];
    [self.bladeLength resignFirstResponder];
    [self.bladeThickness resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    if (self.skateSize.text.length == 0)
    {
        self.skateSize.placeholder = @"REQUIRED - Size";
        return;
    }
    
    if (self.bladeLength.text.length == 0)
    {
        self.bladeLength.placeholder = @"REQUIRED - Blade Length";
        return;
    }
    
    if (self.bladeThickness.text.length == 0)
    {
        self.bladeThickness.placeholder = @"REQUIRED - Blade Thickness";
        return;
    }
    
    NSDateFormatter *isoDate = [[NSDateFormatter alloc] init];
    [isoDate setDateFormat:@"yyyy-MM-dd'T'hh:mm"];
    NSString *dateAssigned = [isoDate stringFromDate:[NSDate date]];
    NSString *dateReleased = [isoDate stringFromDate:[self.releaseDate date]];
    
    NSString *name = [NSString stringWithFormat:@"%@ %@", self.brand.text, self.modelCode.text];
    
    NSDictionary *d = @{@"Name":name, @"Model":self.modelCode.text, @"Cost":[NSNumber numberWithDouble:92.55], @"ReleaseDate":dateReleased, @"RetireDate":dateAssigned, @"Brand":self.brand.text, @"Manufacturer":self.manufacturer.text, @"Size":[NSNumber numberWithInt:[self.skateSize.text intValue]], @"BladeLength":[NSNumber numberWithInt:[self.bladeLength.text intValue]], @"BladeThickness":[NSNumber numberWithInt:[self.bladeThickness.text intValue]], @"Curvature":[NSNumber numberWithInt:32], @"HollowRadius":[NSNumber numberWithInt:[self.bladeThickness.text intValue]]};
    
    // Call the delegate, pass in nil
    [self.delegate AddSkatesController:self didEditItem:d];
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self.delegate AddSkatesController:self didEditItem:nil];
}

- (IBAction)datePicker:(UIDatePicker *)sender {
}
@end
