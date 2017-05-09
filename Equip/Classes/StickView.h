//
//  SticksView.h
//  Equip
//
//  Created by William Wong on 2014-04-08.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageResize.h"
#import "StickList.h"

@interface StickView : UIViewController <ItemSelector3>

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) Player *p;
@property (nonatomic, strong) Stick *s;

//user interface objects
@property (weak, nonatomic) IBOutlet UILabel *manufacturer;
@property (weak, nonatomic) IBOutlet UILabel *brand;
@property (weak, nonatomic) IBOutlet UILabel *modelCode;
@property (weak, nonatomic) IBOutlet UILabel *orderCode;
@property (weak, nonatomic) IBOutlet UILabel *colour;
@property (weak, nonatomic) IBOutlet UILabel *curve;
@property (weak, nonatomic) IBOutlet UILabel *flex;

@property (weak, nonatomic) IBOutlet UIImageView *photo;

@end
