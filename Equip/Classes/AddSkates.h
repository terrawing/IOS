//
//  AddSkates.h
//  Equip
//
//  Created by William Wong on 2014-04-09.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddSkatesDelegate;

@interface AddSkates : UIViewController

//Declare the class delegate property
@property (nonatomic, weak) id <AddSkatesDelegate> delegate;

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) NSDictionary *detailItem;

//user interface objects
@property (weak, nonatomic) IBOutlet UITextField *manufacturer;
@property (weak, nonatomic) IBOutlet UITextField *brand;
@property (weak, nonatomic) IBOutlet UITextField *modelCode;
@property (weak, nonatomic) IBOutlet UITextField *skateSize;
@property (weak, nonatomic) IBOutlet UITextField *bladeLength;
@property (weak, nonatomic) IBOutlet UITextField *bladeThickness;
@property (weak, nonatomic) IBOutlet UIDatePicker *releaseDate;

- (IBAction)save:(UIBarButtonItem *)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)datePicker:(UIDatePicker *)sender;

@end

//Declare a protocol with at lease one method of use
@protocol AddSkatesDelegate <NSObject>

- (void) AddSkatesController:(id)controller didEditItem:(id)item;

@end