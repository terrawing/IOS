//
//  GlovesView.m
//  Equip
//
//  Created by William Wong on 2014-04-07.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "GlovesView.h"
#import "GlovesList.h"

@interface GlovesView ()

@end

@implementation GlovesView

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Load the user interface
    self.manufacturer.text = self.g.manufacturer;
    self.brand.text = self.g.brand;
    self.modelCode.text = self.g.modelCode;
    self.orderCode.text = self.g.orderCode;
    self.colour.text = self.g.colour;
    self.size.text = [NSString stringWithFormat:@"%@", (self.g.size ? self.g.size : @"")];
    self.length.text = [NSString stringWithFormat:@"%@", (self.g.length ? self.g.length : @"")];
    self.photo.image = [self.g.photo scaleToSize:CGSizeMake(120.0f, 180.0f)];
}

- (void)viewDidAppear:(BOOL)animated { //when an edit is made refresh the UIView controller
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue Method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toGlovesList"])
    {
        
        // Configure the next view + controller
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        GlovesList *nextVC = (GlovesList *)nav.topViewController;
        
        nextVC.title = @"Gloves List";
        nextVC.model = self.model;
        nextVC.delegate = self;
    }
}

#pragma mark - Delegate methods

- (void)itemSelectorController:(id)controller didSelectItem:(id)item {
    
    //save it to the current gloves object for displaying back to the user
    NSLog(@"THIS IS THE ITEM BACK/n %@", [item description]);
    
    if(item)
    {
        //create a new gloves in the store with the current player
        [self.model AddNewGloves:item andPlayer:self.p];
        [self.model saveChanges];
        
        //Update the user interface
        NSDictionary *fetchedGloves = (NSDictionary *)item;
        
        self.manufacturer.text = fetchedGloves[@"Manufacturer"];
        self.brand.text = fetchedGloves[@"Brand"];
        self.modelCode.text = fetchedGloves[@"Model"];
        //self.orderCode.text = orderCode;
        self.colour.text = fetchedGloves[@"Color"];
        
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"glovesCat" ofType:@"jpg"];
        UIImage *glovesImage = [UIImage imageWithContentsOfFile:imagePath];
        
        self.photo.image = glovesImage; //If an actual image comes back use that here. Use a default picture for now
        self.size.text = [fetchedGloves[@"Size"] stringValue];
    }
    
    // Dismiss the modal view
    [controller dismissViewControllerAnimated:YES completion:NULL];

}

- (void)viewDidUnload {
    [self setManufacturer:nil];
    [self setBrand:nil];
    [self setModelCode:nil];
    [self setOrderCode:nil];
    [self setColour:nil];
    [self setPhoto:nil];
    [self setSize:nil];
    [self setLength:nil];
    [super viewDidUnload];
}

@end
