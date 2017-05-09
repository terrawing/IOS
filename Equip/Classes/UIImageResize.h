//
//  UIImageResize.h
//  Equip
//
//  Created by William Wong on 2014-03-16.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resizing)

//http://developer.apple.com/iphone/library/documentation/General/Conceptual/DevPedia-CocoaCore/Category.html

- (UIImage *)scaleToSize:(CGSize)size;

@end
