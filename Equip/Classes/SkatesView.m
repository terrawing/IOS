//
//  SkatesView.m
//  Equip
//
//  Created by William Wong on 2014-04-09.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "SkatesView.h"
#import "SkatesList.h"

@interface SkatesView ()

@end

@implementation SkatesView

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
    self.size.text = [NSString stringWithFormat:@"%@", (self.s.size ? self.s.size : @"")];
    self.bladeLength.text = self.s.width;
    self.hollowRadius.text = [NSString stringWithFormat:@"%@", (self.s.stiffness ? self.s.stiffness : @"")];;
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
    if ([segue.identifier isEqualToString:@"toSkatesList"])
    {
        
        // Configure the next view + controller
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        SkatesList *nextVC = (SkatesList *)nav.topViewController;
        
        nextVC.title = @"Skates List";
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
        [self.model AddNewSkates:item andPlayer:self.p];
        [self.model saveChanges];
        
        
        //Update the user interface
        NSDictionary *fetchedSkates = (NSDictionary *)item;
        
        self.manufacturer.text = fetchedSkates[@"Manufacturer"];
        self.brand.text = fetchedSkates[@"Brand"];
        self.modelCode.text = fetchedSkates[@"Model"];
        //self.orderCode.text = orderCode;
        self.colour.text = fetchedSkates[@"Color"];
        
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"skatesCat" ofType:@"jpg"];
        UIImage *stickImage = [UIImage imageWithContentsOfFile:imagePath];
        
        self.photo.image = stickImage; //If an actual image comes back use that here. Use a default picture for now
        self.size.text = [fetchedSkates[@"Size"] stringValue];
        self.bladeLength.text = [fetchedSkates[@"BladeLength"] stringValue];
        self.hollowRadius.text = [fetchedSkates[@"HollowRadius"] stringValue];
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
    [self setBladeLength:nil];
    [self setHollowRadius:nil];
    [super viewDidUnload];
}



@end
