//
//  StickDetailNetworkView.h
//  Equip
//
//  Created by William Wong on 2014-04-08.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StickDetailNetworkView : UIViewController

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) NSDictionary *stickDictionary;

//user interface
@property (weak, nonatomic) IBOutlet UILabel *manufacturer;
@property (weak, nonatomic) IBOutlet UILabel *brand;
@property (weak, nonatomic) IBOutlet UILabel *modelCode;
@property (weak, nonatomic) IBOutlet UILabel *cost;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
@property (weak, nonatomic) IBOutlet UILabel *flex;
@property (weak, nonatomic) IBOutlet UILabel *lie;
@property (weak, nonatomic) IBOutlet UILabel *color;

@property (weak, nonatomic) IBOutlet UIImageView *stickImage;

@end
