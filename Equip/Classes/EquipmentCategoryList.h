//
//  EquipmentCategoryView.h
//  Equip
//
//  Created by William Wong on 2014-03-16.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageResize.h"

@interface EquipmentCategoryList : UITableViewController <NSFetchedResultsControllerDelegate>

// Data for the controller
@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) Player *o;

@end
