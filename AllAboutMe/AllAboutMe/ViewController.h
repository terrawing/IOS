//
//  ViewController.h
//  AllAboutMe
//
//  Created by William Wong on 2014-01-20.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
//set the textfield delegate so the keyboard dismisses

- (IBAction)updateTheTextView:(id)sender;
    //From segment 1, but any object will affect the textview
    //Segment 1, segment 2, slider and textfield interface objs are connected to this method, so any movement will run this method

- (IBAction)changedSlider:(UISlider *)sender; //slider action

- (IBAction)changedTextField:(UITextField *)sender; //textfield action

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UITextView *tvResult;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segProgram;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segSemester;

@property (weak, nonatomic) IBOutlet UISlider *slGPA;

@property (weak, nonatomic) IBOutlet UITextField *tfGPA;

@end
