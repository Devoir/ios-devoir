//
//  TestViewController.m
//  ios-devoir
//
//  Created by Brent on 1/23/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import "TestViewController.h"

@implementation TestViewController

@synthesize userModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    userModel = [[UserModel alloc] init];
    User* user = [userModel getUser];
    self.nameTextField.text = [user displayName];
    self.nameTextField.enabled = NO;
    self.emailTextField.text = [user email];
    self.emailTextField.enabled = NO;
    self.imageTextField.text = [user oAuthToken];
    self.imageTextField.enabled = NO;
}

- (IBAction)signOut:(id)sender {
    [[GPPSignIn sharedInstance] signOut];
    [userModel removeUser];
    [self performSegueWithIdentifier:@"logout" sender:self];
}

- (void)disconnect {
    [[GPPSignIn sharedInstance] disconnect];
}

- (void)didDisconnectWithError:(NSError *)error {
    if (error)
    {
        NSLog(@"Received error %@", error);
    }
    else
    {
        NSLog(@"Logged out");
    }
}

@end
