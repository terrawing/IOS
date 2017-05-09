//
//  AddGloves.h
//  Equip
//
//  Created by William Wong on 2014-04-07.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddGlovesDelegate;

@interface AddGloves : UIViewController

//Declare the class delegate property
@property (nonatomic, weak) id <AddGlovesDelegate> delegate;

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) NSDictionary *detailItem;

//user interface objects

@property (weak, nonatomic) IBOutlet UITextField *manufacturer;
@property (weak, nonatomic) IBOutlet UITextField *brand;
@property (weak, nonatomic) IBOutlet UITextField *modelCode;
@property (weak, nonatomic) IBOutlet UITextField *size;
@property (weak, nonatomic) IBOutlet UITextField *colour;
@property (weak, nonatomic) IBOutlet UIDatePicker *releaseDate;

- (IBAction)datePicker:(UIDatePicker *)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)save:(UIBarButtonItem *)sender;

@end

//Declare a protocol with at lease one method of use
@protocol AddGlovesDelegate <NSObject>

- (void) AddGlovesController:(id)controller didEditItem:(id)item;

@end
