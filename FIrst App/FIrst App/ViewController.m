//
//  ViewController.m
//  FIrst App
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doSomething:(UIButton *)sender {
    self.results.text = self.userInput.text;
    
    self.userInput.text = @"";
    
    [self.userInput resignFirstResponder];
}

@end
