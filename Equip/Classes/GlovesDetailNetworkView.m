//
//  GlovesDetailNetworkView.m
//  Equip
//
//  Created by William Wong on 2014-04-07.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "GlovesDetailNetworkView.h"

@interface GlovesDetailNetworkView ()

@end

@implementation GlovesDetailNetworkView

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
    
    self.manufacturer.text = self.glovesDictionary[@"Manufacturer"];
    self.brand.text = self.glovesDictionary[@"Brand"];
    self.modelCode.text = self.glovesDictionary[@"Model"];
    self.cost.text = [NSString stringWithFormat:@"$%@", self.glovesDictionary[@"Cost"]];
    
    if(self.glovesDictionary[@"ReleaseDate"] != [NSNull null])
    {
        NSString *date = [self.glovesDictionary[@"ReleaseDate"] description];
        NSString *year = [date substringToIndex:4];
        NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
        NSString *day = [date substringWithRange:NSMakeRange(8, 2)];
        
        self.releaseDate.text = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    }
    else
        self.releaseDate.text = @"";
    
    if(self.glovesDictionary[@"RetireDate"] != [NSNull null])
    {
        NSString *date = [self.glovesDictionary[@"RetireDate"] description];
        NSString *year = [date substringToIndex:4];
        NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
        NSString *day = [date substringWithRange:NSMakeRange(8, 2)];
        
        self.retireDate.text = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    }
    else
        self.retireDate.text = @"";
    
    self.size.text = [self.glovesDictionary[@"Size"] stringValue];
    self.color.text = self.glovesDictionary[@"Color"];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"glovesCat" ofType:@"jpg"];
    UIImage *glovesImage = [UIImage imageWithContentsOfFile:imagePath];
    
    self.glovesImage.image = glovesImage;
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
    [self setGlovesImage:nil];
    [self setColor:nil];
    [super viewDidUnload];
}

@end
