//
//  AddStick.h
//  Equip
//
//  Created by William Wong on 2014-04-08.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddStickDelegate;

@interface AddStick : UIViewController

//Declare the class delegate property
@property (nonatomic, weak) id <AddStickDelegate> delegate;

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) NSDictionary *detailItem;

//user interface objects
@property (weak, nonatomic) IBOutlet UITextField *manufacturer;
@property (weak, nonatomic) IBOutlet UITextField *brand;
@property (weak, nonatomic) IBOutlet UITextField *modelCode;
@property (weak, nonatomic) IBOutlet UITextField *flex;
@property (weak, nonatomic) IBOutlet UITextField *lie;
@property (weak, nonatomic) IBOutlet UITextField *colour;
@property (weak, nonatomic) IBOutlet UIDatePicker *releaseDate;

- (IBAction)save:(UIBarButtonItem *)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)datePicker:(UIDatePicker *)sender;

@end

//Declare a protocol with at lease one method of use
@protocol AddStickDelegate <NSObject>

- (void) AddStickController:(id)controller didEditItem:(id)item;

@end
