//
//  Login.h
//  Equip
//
//  Created by William Wong on 2014-03-16.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"

@interface Login : UIViewController

@property (nonatomic, strong) Model *model;

@property (nonatomic, copy) NSString *authToken;
@property (nonatomic, copy) NSDictionary *test;



//user interface objects

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UILabel *loginStatus;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

//user actions
- (IBAction)login:(UIButton *)sender;

@end
