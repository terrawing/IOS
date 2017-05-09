//
//  HelmetView.h
//  Equip
//
//  Created by William Wong on 2014-03-26.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageResize.h"
#import "HelmetList.h"

@interface HelmetView : UIViewController <ItemSelector>

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) Player *p;
@property (nonatomic, strong) Helmet *h;

//User interface objects

@property (weak, nonatomic) IBOutlet UILabel *manufacturer;
@property (weak, nonatomic) IBOutlet UILabel *brand;
@property (weak, nonatomic) IBOutlet UILabel *modelCode;
@property (weak, nonatomic) IBOutlet UILabel *orderCode;
@property (weak, nonatomic) IBOutlet UILabel *colour;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *size;
@property (weak, nonatomic) IBOutlet UILabel *faceProtector;
@property (weak, nonatomic) IBOutlet UILabel *chinStrap;

//Change equipment button


@end
