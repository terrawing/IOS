//
//  AddHelmet.h
//  Equip
//
//  Created by William Wong on 2014-03-29.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddHelmetDelegate;

@interface AddHelmet : UIViewController

//Declary the class delegate property
@property (nonatomic, weak) id <AddHelmetDelegate> delegate;

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) NSDictionary *detailItem;

//user interface objects

@property (weak, nonatomic) IBOutlet UITextField *manufacturer;
@property (weak, nonatomic) IBOutlet UITextField *brand;
@property (weak, nonatomic) IBOutlet UITextField *modelCode;
@property (weak, nonatomic) IBOutlet UITextField *colour;
@property (weak, nonatomic) IBOutlet UITextField *size;
@property (weak, nonatomic) IBOutlet UIDatePicker *releaseDate;

- (IBAction)datePicker:(UIDatePicker *)sender;
- (IBAction)save:(UIBarButtonItem *)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;

@end

//Declare a protocol with at lease one method of use
@protocol AddHelmetDelegate <NSObject>

- (void) AddHelmetController:(id)controller didEditItem:(id)item;

@end