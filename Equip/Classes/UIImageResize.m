//
//  UIImageResize.m
//  Equip
//
//  Created by William Wong on 2014-03-16.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "UIImageResize.h"

@implementation UIImage (Resizing)

- (UIImage *)scaleToSize:(CGSize)size
{
    //Being working with an image context
    UIGraphicsBeginImageContext(size);
    
    // Setup resizing settings
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, 0.0, size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	// Perform the resizing
	CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
	
	// Save the results in a new image
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// Shut down the image context
	UIGraphicsEndImageContext();
	
	return scaledImage;

}

@end
