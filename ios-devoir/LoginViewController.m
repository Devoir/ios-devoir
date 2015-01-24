//
//  LoginViewController.m
//  ios-devoir
//
//  Created by Brent on 1/23/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize signInButton, signIn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.signOutButton.hidden = YES;
    
    signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;
    
    signIn.clientID = GPLUS_CLIENT_ID;
    
    signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    signIn.delegate = self;
    
    BOOL look = [signIn trySilentAuthentication];
    if(look)
    {
        //ADD SOME SORT OF GRAPHIC SPINNER THING HERE
        NSLog(@"LOGGING IN...");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshInterfaceBasedOnSignIn {
    if ([[GPPSignIn sharedInstance] authentication])
    {
        // The user is signed in.
        [self performSegueWithIdentifier:@"login_success" sender:self];
    }
    else
    {
        //signed out
    }
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error: (NSError *) error {
    if (error)
    {
        NSLog(@"Received error %@", error);
    }
    else
    {
        GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
        plusService.retryEnabled = YES;
        [plusService setAuthorizer:auth];
        
        GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
        
        [plusService executeQuery:query
                completionHandler:^(GTLServiceTicket *ticket,
                                    GTLPlusPerson *person,
                                    NSError *error) {
                    if (error)
                    {
                        GTMLoggerError(@"Error: %@", error);
                    }
                    else
                    {
                        //add user into database
                        NSString* name = [NSString stringWithFormat: @"%@", person.displayName];
                        NSString* email = signIn.authentication.userEmail;
                        NSMutableDictionary* imageJson = [person.image JSON];
                        NSString* image = imageJson[@"url"];
                        UserModel* userModel = [[UserModel alloc] init];
                        [userModel addUserWithDisplayName:name Email:email UserImageUrl:image];
                        
                        [self refreshInterfaceBasedOnSignIn];
                    }
                }];
    }
}

@end