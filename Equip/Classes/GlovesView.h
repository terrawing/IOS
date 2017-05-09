//
//  GlovesView.h
//  Equip
//
//  Created by William Wong on 2014-04-07.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageResize.h"
#import "GlovesList.h"

@interface GlovesView : UIViewController <ItemSelector2>

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) Player *p;
@property (nonatomic, strong) Gloves *g;

//user interface objects

@property (weak, nonatomic) IBOutlet UILabel *manufacturer;
@property (weak, nonatomic) IBOutlet UILabel *brand;
@property (weak, nonatomic) IBOutlet UILabel *modelCode;
@property (weak, nonatomic) IBOutlet UILabel *orderCode;
@property (weak, nonatomic) IBOutlet UILabel *colour;
@property (weak, nonatomic) IBOutlet UILabel *size;
@property (weak, nonatomic) IBOutlet UILabel *length;
@property (weak, nonatomic) IBOutlet UIImageView *photo;

@end
