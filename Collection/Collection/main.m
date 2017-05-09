//
//  main.m
//  Collection
//
//  Created by William Wong on 2014-01-27.
//  Copyright (c) 2014 William Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        //array a collection of pointer to objects by index value
        //dictionary a collection of pointer to object by key value
        
        NSArray *staticStrings = @[@"red", @"green", @"blue"]; //immutable by default, static cannot change the size
        NSLog(@"\n%@", [staticStrings description]);
        //NSLog(@"\n%@", staticStrings[1]); //green
        
        NSMutableArray *expando = [[NSMutableArray alloc] init]; //array that you don't know the fixed size, so dynamic and can be change.
        //Can only store object types that were boxed, so primitive int, doubles... etc by default won't work. Have to convert to NSNumber first.
        [expando addObject:@"hello"];
        [expando addObject:[NSNumber numberWithInt:23]];
        [expando addObject:[NSNumber numberWithDouble:23.45]];
        [expando addObject:[NSNumber numberWithFloat:23.45f]];
        [expando addObject:staticStrings];
        NSLog(@"\n%@", [expando description]);
        //NSLog(@"\n%@", expando[4]); //staticStrings array
        
        double calc = (double)23 * 6 /8.43;
        NSMutableArray *calculated = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < 10; i++) {
            [calculated addObject:[NSString stringWithFormat:@"Value is %1.2f", ((2 * i) + calc)]]; //NSString object does the boxing regardless anyway, without me telling it to change to NSNumber
        }
        
        NSLog(@"\n%@", [calculated description]);
    }
    return 0;
}

