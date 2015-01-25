//
//  TestViewController.h
//  ios-devoir
//
//  Created by Brent on 1/23/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
#import "UserModel.h"
//#import "User.h"

@interface TestViewController : UIViewController

@property (weak, nonatomic) GPPSignIn* signIn;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageTextField;
@property UserModel* userModel;

- (IBAction) signOut:(id)sender;
- (void) disconnect;
- (void) didDisconnectWithError:(NSError *)error;

@end
