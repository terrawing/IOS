//
//  NetworkListItems.h
//  Equip
//
//  Created by William Wong on 2014-03-28.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddHelmet.h"

// Forward declaration
@protocol ItemSelector;

@interface HelmetList : UITableViewController <NSFetchedResultsControllerDelegate, AddHelmetDelegate>

// Must configure a "delegate" property
@property (nonatomic, weak) id <ItemSelector> delegate;

@property (nonatomic, strong) Model *model;


//User interface items
- (IBAction)cancel:(UIBarButtonItem *)sender;


@end

// Protocol declaration
@protocol ItemSelector <NSObject>

- (void)itemSelectorController:(id)controller didSelectItem:(id)item;

@end