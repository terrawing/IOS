//
//  AddPlayer.h
//  Equip
//
//  Created by William Wong on 2014-03-26.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageResize.h"

@protocol AddPlayerDelegate;

@interface AddPlayer : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>//ALSO USED as an edit player screen

//Declary the class delegate property
@property (nonatomic, weak) id <AddPlayerDelegate> delegate;

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) Player *player; //If there is an edit mode required

//user interface items

@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *height;
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UITextField *jerseyNumber;
@property (weak, nonatomic) IBOutlet UISegmentedControl *position;
@property (weak, nonatomic) IBOutlet UISegmentedControl *playingStatus;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hand;
@property (weak, nonatomic) IBOutlet UIImageView *playerImage;
@property (weak, nonatomic) IBOutlet UITextView *errors;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePic;


- (IBAction)AddPlayerImage:(UIButton *)sender;
- (IBAction)datePicker:(UIDatePicker *)sender;


//Navigation item

- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)save:(UIBarButtonItem *)sender;

- (NSDate *) NewDateFromYear:(int)year month:(int)month day:(int)day; //date converter

@end

//Declare a protocol with at lease one method of use
@protocol AddPlayerDelegate <NSObject>

- (void) AddPlayerController:(id)controller didEditItem:(id)item;

@end


