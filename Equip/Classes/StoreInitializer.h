//
//  StoreInitializer.h
//
//  Created by Peter McIntyre on 2012/06/26.
//  Copyright (c) 2012 Seneca College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreInitializer : NSObject

+ (void)create:(Model *)model;

// Copied from the "Picker Date" example app
+ (NSDate *) NewDateFromYear:(int)year month:(int)month day:(int)day;
+ (NSDate *) NewDateFromYear:(int)year month:(int)month day:(int)day hour:(int)hour min:(int)min;

@end
