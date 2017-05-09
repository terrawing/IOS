//
//  HelmetDetailNetworkView.m
//  Equip
//
//  Created by William Wong on 2014-03-30.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "HelmetDetailNetworkView.h"

@interface HelmetDetailNetworkView ()

@end

@implementation HelmetDetailNetworkView

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
    
    self.manufacturer.text = self.helmetDictionary[@"Manufacturer"];
    self.brand.text = self.helmetDictionary[@"Brand"];
    self.modelCode.text = self.helmetDictionary[@"Model"];
    self.cost.text = [NSString stringWithFormat:@"$%@", self.helmetDictionary[@"Cost"]];
    
    if(self.helmetDictionary[@"ReleaseDate"] != [NSNull null])
    {
        NSString *date = [self.helmetDictionary[@"ReleaseDate"] description];
        NSString *year = [date substringToIndex:4];
        NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
        NSString *day = [date substringWithRange:NSMakeRange(8, 2)];
        
        self.releaseDate.text = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    }
    else
        self.releaseDate.text = @"";
    
    if(self.helmetDictionary[@"RetireDate"] != [NSNull null])
    {
        NSString *date = [self.helmetDictionary[@"RetireDate"] description];
        NSString *year = [date substringToIndex:4];
        NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
        NSString *day = [date substringWithRange:NSMakeRange(8, 2)];
        
        self.retireDate.text = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    }
    else
        self.retireDate.text = @"";

    self.size.text = [self.helmetDictionary[@"Size"] stringValue];
    self.color.text = self.helmetDictionary[@"Color"];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"helmetCat" ofType:@"jpg"];
    UIImage *helmetImage = [UIImage imageWithContentsOfFile:imagePath];
    
    self.helmetImage.image = helmetImage;
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
    [self setRetireDate:nil];
    [self setSize:nil];
    [self setColor:nil];
    [self setHelmetImage:nil];
    [super viewDidUnload];
}

@end
