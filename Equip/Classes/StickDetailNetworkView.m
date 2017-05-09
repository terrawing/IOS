//
//  StickDetailNetworkView.m
//  Equip
//
//  Created by William Wong on 2014-04-08.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "StickDetailNetworkView.h"

@interface StickDetailNetworkView ()

@end

@implementation StickDetailNetworkView

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
    
    self.manufacturer.text = self.stickDictionary[@"Manufacturer"];
    self.brand.text = self.stickDictionary[@"Brand"];
    self.modelCode.text = self.stickDictionary[@"Model"];
    self.cost.text = [NSString stringWithFormat:@"$%@", self.stickDictionary[@"Cost"]];
    
    if(self.stickDictionary[@"ReleaseDate"] != [NSNull null])
    {
        NSString *date = [self.stickDictionary[@"ReleaseDate"] description];
        NSString *year = [date substringToIndex:4];
        NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
        NSString *day = [date substringWithRange:NSMakeRange(8, 2)];
        
        self.releaseDate.text = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    }
    else
        self.releaseDate.text = @"";
    
    self.flex.text = [self.stickDictionary[@"Flex"] stringValue];
    self.lie.text = [self.stickDictionary[@"Lie"] stringValue];
    self.color.text = self.stickDictionary[@"Color"];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"sticksCat" ofType:@"jpg"];
    UIImage *stickImage = [UIImage imageWithContentsOfFile:imagePath];
    
    self.stickImage.image = stickImage;
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
    [self setFlex:nil];
    [self setLie:nil];
    [self setStickImage:nil];
    [self setColor:nil];
    [super viewDidUnload];
}

@end
