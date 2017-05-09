//
//  SticksList.h
//  Equip
//
//  Created by William Wong on 2014-04-08.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddStick.h"

@protocol ItemSelector3;

@interface StickList : UITableViewController <NSFetchedResultsControllerDelegate, AddStickDelegate>

// Must configure a "delegate" property
@property (nonatomic, weak) id <ItemSelector3> delegate;

@property (nonatomic, strong) Model *model;

//User interface items
- (IBAction)cancel:(UIBarButtonItem *)sender;

@end

// Protocol declaration
@protocol ItemSelector3 <NSObject>

- (void)itemSelectorController:(id)controller didSelectItem:(id)item;

@end