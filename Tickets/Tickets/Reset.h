//
//  Reset.h
//  Tickets
//
//  Created by William Wong on 2014-02-09.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface Reset : UIViewController <UIAlertViewDelegate>

@property (nonatomic, strong) Model *model;

@property (weak, nonatomic) IBOutlet UILabel *resetResult;

- (IBAction)alertReset:(UIButton *)sender;

- (void)viewWillAppear:(BOOL)animated;

@end
