//
//  PlayerList.h
//
//  Data source is a fetched results controller
//
//  Created by Peter McIntyre on 2012/10/05.
//  Copyright (c) 2012 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageResize.h"
#import "AddPlayer.h"

@interface PlayerList : UITableViewController <NSFetchedResultsControllerDelegate, AddPlayerDelegate>

@property (nonatomic, strong) Model *model;

@end
