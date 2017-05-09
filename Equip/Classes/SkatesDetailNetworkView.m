//
//  SkatesDetailNetworkView.m
//  Equip
//
//  Created by William Wong on 2014-04-09.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "SkatesDetailNetworkView.h"

@interface SkatesDetailNetworkView ()

@end

@implementation SkatesDetailNetworkView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.manufacturer.text = self.skatesDictionary[@"Manufacturer"];
    self.brand.text = self.skatesDictionary[@"Brand"];
    self.modelCode.text = self.skatesDictionary[@"Model"];
    self.cost.text = [NSString stringWithFormat:@"$%@", self.skatesDictionary[@"Cost"]];
    
    if(self.skatesDictionary[@"ReleaseDate"] != [NSNull null])
    {
        NSString *date = [self.skatesDictionary[@"ReleaseDate"] description];
        NSString *year = [date substringToIndex:4];
        NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
        NSString *day = [date substringWithRange:NSMakeRange(8, 2)];
        
        self.releaseDate.text = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    }
    else
        self.releaseDate.text = @"";
    
    self.size.text = [self.skatesDictionary[@"Size"] stringValue];
    self.bladeLength.text = [self.skatesDictionary[@"BladeLength"] stringValue];
    self.hollowRadius.text = [self.skatesDictionary[@"HollowRadius"] stringValue];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"skatesCat" ofType:@"jpg"];
    UIImage *skatesImage = [UIImage imageWithContentsOfFile:imagePath];
    
    self.skatesImage.image = skatesImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setManufacturer:nil];
    [self setBrand:nil];
    [self setModelCode:nil];
    [self setCost:nil];
    [self setReleaseDate:nil];
    [self setSize:nil];
    [self setBladeLength:nil];
    [self setSkatesImage:nil];
    [self setHollowRadius:nil];
    [super viewDidUnload];
}

@end
