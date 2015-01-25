//
//  UserModel.h
//  ios-devoir
//
//  Created by Brent on 1/20/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property NSString* displayName;
@property NSString* email;
@property NSString* oAuthToken;
@property int userID;

@end
