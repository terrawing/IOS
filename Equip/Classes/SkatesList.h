//
//  SkatesList.h
//  Equip
//
//  Created by William Wong on 2014-04-09.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddSkates.h"

@protocol ItemSelector4;

@interface SkatesList : UITableViewController <NSFetchedResultsControllerDelegate, AddSkatesDelegate>

// Must configure a "delegate" property
@property (nonatomic, weak) id <ItemSelector4> delegate;

@property (nonatomic, strong) Model *model;

//User interface items
- (IBAction)cancel:(UIBarButtonItem *)sender;

@end

// Protocol declaration
@protocol ItemSelector4 <NSObject>

- (void)itemSelectorController:(id)controller didSelectItem:(id)item;

@end