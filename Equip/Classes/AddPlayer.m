//
//  AddPlayer.m
//  Equip
//
//  Created by William Wong on 2014-03-26.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "AddPlayer.h"

@interface AddPlayer ()

@end

@implementation AddPlayer //ALSO FOR EDIT

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Dismiss the keyboard when clicking somwhere else besides the username/pass textfield
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    if(self.player)
    {
        self.lastName.text = self.player.lastName;
        self.firstName.text = self.player.givenNames;
        self.height.text = [NSString stringWithFormat:@"%@", self.player.height];
        self.weight.text = [NSString stringWithFormat:@"%@", self.player.weight];
        self.jerseyNumber.text = [NSString stringWithFormat:@"%@", self.player.jerseyNumber];
    
        if([self.player.position isEqualToString:@"Centre"]) {
            self.position.selectedSegmentIndex = 0;
        }
        else if([self.player.position isEqualToString:@"Left Wing"]) {
            self.position.selectedSegmentIndex = 1;
        }
        else if([self.player.position isEqualToString:@"Right Wing"]) {
            self.position.selectedSegmentIndex = 2;
        }
        else if([self.player.position isEqualToString:@"Defenceman"]) {
            self.position.selectedSegmentIndex = 3;
        }
        else {
            self.position.selectedSegmentIndex = 4;
        }
    
        if([self.player.playingStatus isEqualToString:@"Active"]) {
            self.playingStatus.selectedSegmentIndex = 0;
        }
        else {
            self.playingStatus.selectedSegmentIndex = 1;
        }
    
        if([self.player.handedness isEqualToString:@"Left"]) {
            self.hand.selectedSegmentIndex = 0;
        }
        else {
            self.hand.selectedSegmentIndex = 1;
        }
    
        self.datePic.date = self.player.birthDate;
    
        self.playerImage.image = [self.player.photoHeadshot scaleToSize:CGSizeMake(120.0f, 180.0f)];
    
    }
    self.errors.text = @"";
    
}

-(void)dismissKeyboard {
    [self.lastName resignFirstResponder];
    [self.firstName resignFirstResponder];
    [self.height resignFirstResponder];
    [self.weight resignFirstResponder];
    [self.jerseyNumber resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDate *) NewDateFromYear:(int)year month:(int)month day:(int)day
{
	NSCalendar *c = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *dc = [[NSDateComponents alloc] init];
	[dc setYear:year];
	[dc setMonth:month];
	[dc setDay:day];
	[dc setHour:0];
	[dc setMinute:0];
	return [c dateFromComponents:dc];
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(UIBarButtonItem *)sender {
    
    //Dismiss the keyboard
    [[self view] endEditing:NO];
    
    //Do validations for text fields
    self.errors.text = @""; //set it to nothing first
    
    if([self.firstName.text length] == 0)
    {
        self.errors.text = @"- Given name is required\n";
        [self.firstName resignFirstResponder];
    }
    
    if([self.lastName.text length] == 0)
    {
        self.errors.text = [NSString stringWithFormat:@"%@- Last name is required\n", self.errors.text];
        [self.lastName resignFirstResponder];
    }
    
    if([self.height.text length] == 0)
    {
        self.errors.text = [NSString stringWithFormat:@"%@- Height is required\n", self.errors
                            .text];
        [self.height resignFirstResponder];
    }
    
    if([self.weight.text length] == 0)
    {
        self.errors.text = [NSString stringWithFormat:@"%@- Weight is required\n", self.errors.text];
        [self.weight resignFirstResponder];
    }
    
    if([self.jerseyNumber.text length] == 0)
    {
        self.errors.text = [NSString stringWithFormat:@"%@- Jersey number is required\n", self.errors.text];
        [self.jerseyNumber resignFirstResponder];
    }
    
    NSString *position = @"";
    
    //get the segment items
    switch (self.position.selectedSegmentIndex) {
        case 0: //center
        {
            position = @"Centre";
        }
            break;
            
        case 1: //left wing
        {
            position = @"Left Wing";
        }
            break;
            
        case 2: //right wing
        {
            position = @"Right Wing";
        }
            break;
            
        case 3: //Defenceman
        {
            position = @"Defenceman";
        }
            
        default:
            position = @"Goaltender";
    }
    
    NSString *playingStatus = (self.playingStatus.selectedSegmentIndex == 0) ? @"Active" : @"InActive";
    
    NSString *hand = (self.hand.selectedSegmentIndex == 0) ? @"Left" : @"Right";
    
    //Get the date
    NSString *date = [self.datePic.date description];
    int year = [[date substringToIndex:4] intValue];
    int month = [[date substringWithRange:NSMakeRange(5, 2)] intValue];
    int day = [[date substringWithRange:NSMakeRange(8, 2)] intValue];
    
    //NSLog(@"This is the date: %d %d %d", year, month, day);
    
    //Test if user got a picture
    if(self.playerImage.image == NULL)
    {
        self.errors.text = [NSString stringWithFormat:@"%@- Player portrait is required\n", self.errors.text];
        [self.playerImage resignFirstResponder];
        
    }
    
    //Call back to the delegate, only if there are no errors
    //Pass the values from the user interface
    
    if([self.errors.text length] == 0) {
        NSDate *birthDate = [self NewDateFromYear:year month:month day:day];
        
        //Change this later to get the actual picture which was taken by the user and save it somewhere
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"PKessel" ofType:@"jpg"];
        UIImage *playerImage = [UIImage imageWithContentsOfFile:imagePath];
        //End of change this later ------------------------------- //
        
        //Check the title is "Add Player" or "Edit Player" to do the following
        if([self.title isEqualToString:@"Add Player"]) {
        
        //Make a dictionary to package user input
            NSDictionary *d = @{@"lastName": self.lastName.text,
                                @"givenNames": self.firstName.text,
                                @"photoHeadshot": playerImage,
                                @"jerseyNumber": [NSNumber numberWithInt:[self.jerseyNumber.text intValue]],
                                @"position": position,
                                @"handedness": hand,
                                @"playingStatus": playingStatus,
                                @"birthDate": birthDate,
                                @"height": [NSNumber numberWithInt:[self.height.text intValue]],
                                @"weight": [NSNumber numberWithInt:[self.weight.text intValue]] };
        
            //calling the delegate method passing along the user input
            [self.delegate AddPlayerController:self didEditItem:d];
        }
        else { //Edit an existing player
            //Update the current player object in the view with the new changed data
            self.player.lastName = self.lastName.text;
            self.player.givenNames = self.firstName.text;
            //self.player.photoHeadshot = playerImage;
            self.player.jerseyNumber = [NSNumber numberWithInt:[self.jerseyNumber.text intValue]];
            self.player.position = position;
            self.player.handedness = hand;
            self.player.playingStatus = playingStatus;
            self.player.birthDate = birthDate;
            self.player.height = [NSNumber numberWithInt:[self.height.text intValue]];
            self.player.weight = [NSNumber numberWithInt:[self.weight.text intValue]];
            
            //Save edit changes to the store and pass nil back so it doesn't add a new player core data
            [self.model saveChanges];
            [self.delegate AddPlayerController:self didEditItem:nil];
        }
    }

}

- (IBAction)AddPlayerImage:(UIButton *)sender {
    // Create an instance of the image picker
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // Check whether the device has a camera - if not, we'll use the photo library
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		// Camera action
		imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
	} else {
		// Photo library action
		imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	}

    // Set this object to be its delegate; we do this for code-created controllers/objects
	imagePicker.delegate = self;
	
	// Don't support editing for now
	imagePicker.allowsEditing = NO;
    
	// Present the image picker
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

- (IBAction)datePicker:(UIDatePicker *)sender {}

#pragma mark - Delegate methods

// Handles the selection of an image
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	// Get the image that was selected
	UIImage *selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    CGImageRef imgRef = selectedImage.CGImage;
    CGFloat w = CGImageGetWidth(imgRef);
    CGFloat h = CGImageGetHeight(imgRef);
    UIImageOrientation orient = selectedImage.imageOrientation;
    
    NSLog(@"\nFYI - Width %1.1f, Height %1.1f, Orientation %d", w, h, orient);
    
    // If the image is too big, scale it smaller
    
    UIImage *image = nil;
    
    if (w > 160.0f)
    {
        // This means that it was taken by the camera
        // We must rotate and scale the image
        
        // This code was obtained from...
        // http://stackoverflow.com/questions/538041/uiimagepickercontroller-camera-preview-is-portrait-in-landscape-app
        
        CGAffineTransform transform = CGAffineTransformIdentity;
        CGRect bounds = CGRectMake(0, 0, w, h);
        CGFloat boundHeight;
        CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
        CGFloat scaleRatio = bounds.size.width / w;
        
        boundHeight = bounds.size.height;
        bounds.size.height = bounds.size.width;
        bounds.size.width = boundHeight;
        transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
        transform = CGAffineTransformRotate(transform, M_PI / 2.0);
        
        UIGraphicsBeginImageContext(bounds.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -h, 0);
        CGContextConcatCTM(context, transform);
        
        CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, w, h), imgRef);
        UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        image = [imageCopy scaleToSize:CGSizeMake(123.0f, 162.0f)];
    }
    else
    {
        image = selectedImage;
    }
    
	// Show it
	self.playerImage.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidUnload
{
    [self setPlayerImage:nil];
    [super viewDidUnload];
}

@end
