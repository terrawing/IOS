//
//  ViewController.m
//  AllAboutMe
//
//  Created by William Wong on 2014-01-20.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    //load only once (during the lifetime of the app when the viewcontroller loads/initialized
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tfGPA.text = [NSString stringWithFormat:@"%1.2f", (self.slGPA.value)]; //assign the gpa text field from the slider
    
    [self updateTheTextView:nil]; //have to set to nil as the sender argument for id
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateTheTextView:(id)sender {
    NSString *program = (self.segProgram.selectedSegmentIndex == 0) ? @"CPA" : @"BSD";
    
    NSString *semester = [NSString stringWithFormat:@"%d", (self.segSemester.selectedSegmentIndex + 5)]; //seg 0 = sem 5, seg 1 = sem 6 ...etc
    
    NSString *gpa = [NSString stringWithFormat:@"%1.2f", (self.slGPA.value)];
    
    self.tvResult.text = [NSString stringWithFormat:@"My name is %@. I am in the %@ program, in semester %@. My GPA is %@.", (self.nameLabel.text), program, semester, gpa];
    
}

- (IBAction)changedSlider:(UISlider *)sender {
    self.tfGPA.text = [NSString stringWithFormat:@"%1.2f", (self.slGPA.value)];
    
    [self updateTheTextView:nil];
}

- (IBAction)changedTextField:(UITextField *)sender {
    float gpa = [self.tfGPA.text floatValue]; //take the text string from the textfield and convert to float and assign the variable to it
    
    if(gpa > 4.00) {
        gpa = 4.00;
        self.slGPA.value = 4.00;
    }
    else if(gpa < 2.00) {
        gpa = 2.00;
        self.slGPA.value = 2.00;
    }
    else
        self.slGPA.value = gpa; //textfield should move the slider as well
    
    self.tfGPA.text = [NSString stringWithFormat:@"%1.2f", gpa];
    
    [self updateTheTextView:nil];
}

//Delegate methods

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    //NSLog(@"\n%s", __FUNCTION__);
    
    // Move the view up
    
    // Make a CGRect for the view (which should be positioned at 0,0 and be 320px wide and 480px tall)
    CGRect viewFrame = self.view.frame;
    
    // Adjust the origin for the viewFrame CGRect
    viewFrame.origin.y -= 150.0f;
    
    // The following animation setup just makes it look nice when shifting
    // We don't really need the animation code, but we'll leave it in here
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    
    // Apply the new shifted vewFrame to the view
    [self.view setFrame:viewFrame];
    
    // More animation code
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    //NSLog(@"\n%s", __FUNCTION__);
    
    // Move the view down
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += 150.0f;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
    // NSLog the result
    //NSLog(@"\nText entered was '%@'", textField.text);
}


@end
