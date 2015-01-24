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
        //TRY TO LOGIN ON SERVER
        NSString* loginResponse = [[FakeServer sharedFakeServer] sendLoginRequestOAuthToken:[auth accessToken]];
        NSDictionary* loginJson = [self parseLoginResponse:loginResponse];
        
        //add user into database
        UserModel* userModel = [[UserModel alloc] init];
        [userModel addUserWithDisplayName:(NSString*)loginJson[@"DisplayName"]
                                    Email:(NSString*)loginJson[@"Email"]
                               OAuthToken:(NSString*)loginJson[@"OAuthToken"]
                                   UserID:(int)loginJson[@"UserID"]];
        [self refreshInterfaceBasedOnSignIn];
    }
}

-(NSDictionary*)parseLoginResponse:(NSString *)response
{
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = [[NSError alloc] init];
    NSDictionary* jsonData = [NSJSONSerialization
                         JSONObjectWithData:data
                         options:NSJSONReadingMutableContainers
                         error:&error];
    return jsonData;
}

@end