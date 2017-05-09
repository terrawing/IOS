//
//  SticksView.m
//  Equip
//
//  Created by William Wong on 2014-04-08.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "StickView.h"
#import "StickList.h"

@interface StickView ()

@end

@implementation StickView


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Load the user interface
    self.manufacturer.text = self.s.manufacturer;
    self.brand.text = self.s.brand;
    self.modelCode.text = self.s.modelCode;
    self.orderCode.text = self.s.orderCode;
    self.colour.text = self.s.colour;
    self.curve.text = [NSString stringWithFormat:@"%@", (self.s.curve ? self.s.curve : @"")];
    self.flex.text = [NSString stringWithFormat:@"%@", (self.s.flex ? self.s.flex : @"")];
    self.photo.image = [self.s.photo scaleToSize:CGSizeMake(120.0f, 180.0f)];
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
    if ([segue.identifier isEqualToString:@"toStickList"])
    {
        
        // Configure the next view + controller
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        StickList *nextVC = (StickList *)nav.topViewController;
        
        nextVC.title = @"Sticks List";
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
        [self.model AddNewStick:item andPlayer:self.p];
        [self.model saveChanges];
        
        
        //Update the user interface
        NSDictionary *fetchedStick = (NSDictionary *)item;
        
        self.manufacturer.text = fetchedStick[@"Manufacturer"];
        self.brand.text = fetchedStick[@"Brand"];
        self.modelCode.text = fetchedStick[@"Model"];
        //self.orderCode.text = orderCode;
        self.colour.text = fetchedStick[@"Color"];
        
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"sticksCat" ofType:@"jpg"];
        UIImage *stickImage = [UIImage imageWithContentsOfFile:imagePath];
        
        self.photo.image = stickImage; //If an actual image comes back use that here. Use a default picture for now
        self.curve.text = [fetchedStick[@"Lie"] stringValue];
        self.flex.text = [fetchedStick[@"Flex"] stringValue];
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
    [self setCurve:nil];
    [self setFlex:nil];
    [super viewDidUnload];
}


@end
