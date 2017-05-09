//
//  ViewController.h
//  2ndthing
//
//  Created by William Wong on 2014-01-20.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *itemSelector; //segment outlet

@property (weak, nonatomic) IBOutlet UILabel *segmentResults;

@property (weak, nonatomic) IBOutlet UISlider *sliderSelector;//segment outlet slider, if you want current state

@property (weak, nonatomic) IBOutlet UIImageView *myImage;

@property (weak, nonatomic) IBOutlet UILabel *sliderResults;

@property (weak, nonatomic) IBOutlet UIStepper *myStepper;

- (IBAction)stepWasTapped:(UIStepper *)sender;

- (IBAction)sliderValueChanged:(UISlider *)sender;//segment action for the slider, if you want to know if the slider has been changed

- (IBAction)selectorWasTapped:(UISegmentedControl *)sender; //segment action as well, using both outlet and action

@end
