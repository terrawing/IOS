//
//  ViewController.m
//  2ndthing
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
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    int oldSelection = self.itemSelector.selectedSegmentIndex;
    
    self.itemSelector.selectedSegmentIndex = -1;
    
    self.segmentResults.text = [NSString stringWithFormat:@"Was %d, now %d, 'not selected'", oldSelection, self.itemSelector.selectedSegmentIndex];

    self.myImage.image = [UIImage imageNamed:@"test.jpg"]; //at run time load the image
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stepWasTapped:(UIStepper *)sender {
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    
    
}

- (IBAction)selectorWasTapped:(UISegmentedControl *)sender {
    //sender is the generic name
    
    self.segmentResults.text = [NSString stringWithFormat:@"Now %d", self.itemSelector.selectedSegmentIndex];
    
    switch(sender.selectedSegmentIndex) { //also as self.itemSelector.selectedSegmentIndex
        case 0:
            //do something
            NSLog(@"seg 0");
            break;
        
        case 1:
            //do something
            NSLog(@"seg 1");
            break;
            
        case 2:
            //do something
            break;
            
        default:
            break;
    }
}
@end
