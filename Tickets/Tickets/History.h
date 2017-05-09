//
//  History.h
//  Tickets
//
//  Created by William Wong on 2014-02-09.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface History : UIViewController

@property (nonatomic, strong) Model *model;

@property (weak, nonatomic) IBOutlet UITextView *purchaseHistory;

- (void)viewWillAppear: (BOOL)animated;

@end
