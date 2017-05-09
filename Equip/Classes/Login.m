//
//  Login.m
//  Equip
//
//  Created by William Wong on 2014-03-16.
//  Copyright (c) 2014 Seneca College. All rights reserved.
//

#import "Login.h"
#import "PlayerList.h"
#import "WebServiceRequest.h"

@interface Login ()
{
    Team *_fr_team;
}

@end

@implementation Login

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Dismiss the keyboard when clicking somwhere else besides the username/pass textfield
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    _fr_team = self.model.fr_team;
    NSLog(@"_fr_team viewDidLoad: %@", [_fr_team description]);
    
    // Register for a notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginResult:) name:@"Login_authToken_fetch_completed" object:nil];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Wolfpack" ofType:@"gif"];
    UIImage *logoImage = [UIImage imageWithContentsOfFile:imagePath];
    
    self.logoImage.image = logoImage;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.model.authToken = @"";
}


-(void)dismissKeyboard {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notifications


- (void)loginResult:(NSNotification *)notification
{
    //If the login attempt was successful
    if([self.authToken length] > 0)
    {
        //Clean up the user interface
        self.username.text = @"";
        self.password.text = @"";
        self.loginStatus.text = @"";
        [self.activity stopAnimating];
        
        //save the token to the model class, so it can be used everywhere
        self.model.authToken = self.authToken;
        
        //If there is no team object, fetch from web service and store it on device
        if(!_fr_team)
        {
            //fetch the team data from the web service
            NSLog(@"Fetch team data\n");
            [self.model fetchTeamRequest:@"russell.holdredge"];
        }

        //Otherwise team object exists with players and segue to playerList
        
        [self performSegueWithIdentifier:@"toPlayerList" sender:self]; //segue to the next scene
    }
    else
    {
        [self.activity stopAnimating];
        self.username.text = @"";
        self.password.text = @"";
        self.loginStatus.text = @"Invalid username or password";
    }
    
    [self.loginButton setEnabled:YES];
}

- (IBAction)login:(UIButton *)sender {
    //Dismiss the keyboard and clear existing login status message
    [self.view endEditing:YES];
    self.loginStatus.text = @"";
    
    if (self.username.text.length > 0 & self.password.text.length > 0)
    {
        //Take this part out later
        /*
        [self.model fetchTeamRequest:@"russell.holdredge"];
         
        [self performSegueWithIdentifier:@"toPlayerList" sender:self]; //segue to the next scene
        
        self.username.text = @"";
        self.password.text = @"";
        self.loginStatus.text = @"";
        [self.activity stopAnimating];
        [self.loginButton setEnabled:YES];
         //Take this part out later
        */
         
        //user has logged in before and team data is stored
        if(_fr_team.username.length > 0 & _fr_team.password > 0)
        {
            BOOL isUsernameOK;
            BOOL isPasswordOK;
            
            NSString *storedUsername = _fr_team.username;
            NSString *storedPassword = _fr_team.password;
            
            //compare username - case insensitive
            isUsernameOK = [self.username.text caseInsensitiveCompare:storedUsername] == NSOrderedSame;
            
            //compare password - case sensitive
            isPasswordOK = [self.password.text isEqualToString:storedPassword];
            
            if(isPasswordOK && isUsernameOK)
            {
                NSLog(@"Data is already stored and running here:\n\n%@", [_fr_team description]);
                
                //Update the user
                [self.activity startAnimating];
                self.loginStatus.text = @"Login in progress...";
                [self.loginButton setEnabled:NO];
                
                // Create and configure a login request - wwong20 or russell.holdredge / passw[]rd
                WebServiceRequest *login = [[WebServiceRequest alloc] init];
                login.urlBase = [NSString stringWithFormat:@"http://warp.senecac.on.ca:81/bti420_121a42/mobileappgetaccesstoken.aspx?u=%@&p=%@&l=120", storedUsername, storedPassword];
                
                // Send (execute) the login request (which runs in the background)
                [login sendRequestToUrlPath:@"" forDataKeyName:@"Authorization" from:self propertyNamed:@"authToken"];

            }
            else
            {
                self.username.text = @"";
                self.password.text = @"";
                self.loginStatus.text = @"Invalid username or password";
            }
        }
        else //user is logging in for first time, so it is fetching the login data from webservice
        {
            //Update the user
            [self.activity startAnimating];
            self.loginStatus.text = @"Login in progress...";
            [self.loginButton setEnabled:NO];
        
            // Create and configure a login request - wwong20 or russell.holdredge / passw[]rd
            WebServiceRequest *login = [[WebServiceRequest alloc] init];
            login.urlBase = [NSString stringWithFormat:@"http://warp.senecac.on.ca:81/bti420_121a42/mobileappgetaccesstoken.aspx?u=%@&p=%@&l=120", self.username.text, self.password.text];
        
            // Send (execute) the login request (which runs in the background)
            [login sendRequestToUrlPath:@"" forDataKeyName:@"Authorization" from:self propertyNamed:@"authToken"];
            
        }
        
    }
    else
    {
        self.loginStatus.text = @"Invalid credentials";
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toPlayerList"])
    {
        PlayerList *vc = (PlayerList *)[segue destinationViewController];
        vc.model = self.model;
        vc.title = @"Players";
    }
}


@end
