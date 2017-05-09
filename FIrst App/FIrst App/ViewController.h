//
//  ViewController.h
//  FIrst App
//
//  Created by William Wong on 2014-01-20.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userInput;

@property (weak, nonatomic) IBOutlet UILabel *results;


- (IBAction)doSomething:(UIButton *)sender; //evaluates to void, just to make the design environment happy, IBOutput evaluates to nothing

@end
