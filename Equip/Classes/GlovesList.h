//
//  GlovesList.h
//  Equip
//
//  Created by William Wong on 2014-04-07.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddGloves.h"

@protocol ItemSelector2;

@interface GlovesList : UITableViewController <NSFetchedResultsControllerDelegate, AddGlovesDelegate>

// Must configure a "delegate" property
@property (nonatomic, weak) id <ItemSelector2> delegate;

@property (nonatomic, strong) Model *model;

//User interface items

- (IBAction)cancel:(UIBarButtonItem *)sender;

@end

// Protocol declaration
@protocol ItemSelector2 <NSObject>

- (void)itemSelectorController:(id)controller didSelectItem:(id)item;

@end