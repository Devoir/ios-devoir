//
//  UserModel.h
//  ios-devoir
//
//  Created by Brent on 1/20/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Constants.h"

@interface UserModel : NSObject

@property NSString* dbName;

- (id) init;
- (id) initWithDatabase:(NSString*)db;

- (NSString*) getDisplayName;
- (NSString*) getEmail;
- (NSString*) getUserImageUrl;


- (int) addUserWithDisplayName:(NSString*)displayName Email:(NSString*)email UserImageUrl:(NSString*)userImageUrl;
- (void) removeUser;


@end
