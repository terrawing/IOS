//
//  HelmetDetailNetworkView.h
//  Equip
//
//  Created by William Wong on 2014-03-30.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelmetDetailNetworkView : UIViewController

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) NSDictionary *helmetDictionary;

//user interface

@property (weak, nonatomic) IBOutlet UILabel *manufacturer;
@property (weak, nonatomic) IBOutlet UILabel *brand;
@property (weak, nonatomic) IBOutlet UILabel *modelCode;
@property (weak, nonatomic) IBOutlet UILabel *cost;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
@property (weak, nonatomic) IBOutlet UILabel *retireDate;
@property (weak, nonatomic) IBOutlet UILabel *size;
@property (weak, nonatomic) IBOutlet UILabel *color;

@property (weak, nonatomic) IBOutlet UIImageView *helmetImage;


@end
