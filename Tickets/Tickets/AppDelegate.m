//
//  AppDelegate.m
//  Tickets
//
//  Created by William Wong on 2014-02-07.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import "AppDelegate.h"
#import "Tickets.h"
#import "History.h"
#import "Reset.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //root is the tab bar controller, get a reference to our root view controller
    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
    
    //all the view controllers are referenced by the array tab bar, object index 0 is the Ticket view controller, object index 1 is the history controler.. etc
    //View Controllers is an NSArray, the leftmost is array 0
    Tickets *tixVC = (Tickets *)[tbc.viewControllers objectAtIndex:0];
    
    //get references to the other 2 controllers on the tab bar
    History *hisVC = (History *)[tbc.viewControllers objectAtIndex:1];
    Reset *rstVC = (Reset *)[tbc.viewControllers objectAtIndex:2];
    
    //Initialize the model object
    Model *model = [[Model alloc] init];
    
    //Pass on the model reference to all controllers
    tixVC.model = model;
    hisVC.model = model;
    rstVC.model = model;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
