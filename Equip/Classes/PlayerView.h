//
//  EntityView.h
//
//  Data source is a custom NSManagedObject subclass
//
//  Created by Peter McIntyre on 2012/10/05.
//  Copyright (c) 2012 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageResize.h"
#import "AddPlayer.h"

@interface PlayerView : UIViewController <NSFetchedResultsControllerDelegate, AddPlayerDelegate>

// Data for the controller
@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) Player *o;

// User interface

@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UILabel *giveName;
@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UILabel *playingStatus;
@property (weak, nonatomic) IBOutlet UILabel *jerseyNumber;
@property (weak, nonatomic) IBOutlet UILabel *height;
@property (weak, nonatomic) IBOutlet UILabel *weight;
@property (weak, nonatomic) IBOutlet UILabel *handedness;
@property (weak, nonatomic) IBOutlet UILabel *dateofBirth;
@property (weak, nonatomic) IBOutlet UIImageView *playerImage;

//Edit button


@end
