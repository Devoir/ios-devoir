//
//  LoginViewController.h
//  ios-devoir
//
//  Created by Brent on 1/23/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import "Constants.h"
#import "UserModel.h"

#import "FakeServer.h"

@class GPPSignInButton;

@interface LoginViewController : UIViewController <GPPSignInDelegate>

@property (retain, nonatomic) IBOutlet GPPSignInButton* signInButton;
@property (weak, nonatomic) IBOutlet UIButton* signOutButton;
@property (weak, nonatomic) IBOutlet UILabel *signInLabel;
@property (weak, nonatomic) GPPSignIn* signIn;

-(void)refreshInterfaceBasedOnSignIn;
-(void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error;
-(NSDictionary*)parseLoginResponse:(NSString*)response;


@end