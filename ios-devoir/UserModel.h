//
//  UserModel.h
//  ios-devoir
//
//  Created by Brent on 1/20/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface UserModel : NSObject

@property NSString* dbName;

- (id) init;
- (id) initWithDatabase:(NSString*)db;
- (NSString*) getFirstName;
- (NSString*) getLastName;
- (NSString*) getEmail;


@end
