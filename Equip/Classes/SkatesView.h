//
//  SkatesView.h
//  Equip
//
//  Created by William Wong on 2014-04-09.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageResize.h"
#import "SkatesList.h"

@interface SkatesView : UIViewController <ItemSelector4>

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) Player *p;
@property (nonatomic, strong) SkateBoot *s;

//user interface objects
@property (weak, nonatomic) IBOutlet UILabel *manufacturer;
@property (weak, nonatomic) IBOutlet UILabel *brand;
@property (weak, nonatomic) IBOutlet UILabel *modelCode;
@property (weak, nonatomic) IBOutlet UILabel *orderCode;
@property (weak, nonatomic) IBOutlet UILabel *colour;
@property (weak, nonatomic) IBOutlet UILabel *size;
@property (weak, nonatomic) IBOutlet UILabel *bladeLength;
@property (weak, nonatomic) IBOutlet UILabel *hollowRadius;

@property (weak, nonatomic) IBOutlet UIImageView *photo;

@end
