//
//  HelmetView.m
//  Equip
//
//  Created by William Wong on 2014-03-26.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "HelmetView.h"
#import "HelmetList.h"

@interface HelmetView ()

@end

@implementation HelmetView

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Load the user interface
    self.manufacturer.text = self.h.manufacturer;
    self.brand.text = self.h.brand;
    self.modelCode.text = self.h.modelCode;
    self.orderCode.text = self.h.orderCode;
    self.colour.text = self.h.colour;
    self.photo.image = [self.h.photo scaleToSize:CGSizeMake(120.0f, 180.0f)];
    self.size.text = [NSString stringWithFormat:@"%@", (self.h.size ? self.h.size : @"")];
    self.faceProtector.text = self.h.faceProtector;
    self.chinStrap.text = self.h.chinStrap;
    
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated { //When an edit is made, refresh the UIView controller
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Segue Method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toHelmetList"])
    {
        
        // Configure the next view + controller
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        HelmetList *nextVC = (HelmetList *)nav.topViewController;
        
        nextVC.title = @"Helmet List";
        nextVC.model = self.model;
        nextVC.delegate = self;
    }
}

#pragma mark - Delegate methods

- (void)itemSelectorController:(id)controller didSelectItem:(id)item {
    
    //save it to the current helmet object for displaying back to the user
    NSLog(@"THIS IS THE ITEM BACK/n %@", [item description]);
    
    if(item)
    {
        //create a new helmet in the store with the current player
        [self.model AddNewHelmet:item andPlayer:self.p];
        [self.model saveChanges];

        // Update the user interface
        NSDictionary *fetchedHelmet = (NSDictionary *)item;

        self.manufacturer.text = fetchedHelmet[@"Manufacturer"];
        self.brand.text = fetchedHelmet[@"Brand"];
        self.modelCode.text = fetchedHelmet[@"Model"];
        //self.orderCode.text = orderCode;
        self.colour.text = fetchedHelmet[@"Color"];
        
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"helmetCat" ofType:@"jpg"];
        UIImage *helmetImage = [UIImage imageWithContentsOfFile:imagePath];

        self.photo.image = helmetImage; //If an actual image comes back use that here. Use a default picture for now
        self.size.text = [fetchedHelmet[@"Size"] stringValue];
        //self.faceProtector.text = faceProtector;
        //self.chinStrap.text = chinStrap;
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
    [self setFaceProtector:nil];
    [self setChinStrap:nil];
    [super viewDidUnload];
}
@end
