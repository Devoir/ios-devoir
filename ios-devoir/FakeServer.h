//
//  FakeServer.h
//  ios-devoir
//
//  Created by Brent on 1/24/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeServer : NSObject

+ (FakeServer*) sharedFakeServer;   // class method to return the singleton object

-(NSString*) sendLoginRequestOAuthToken:(NSString*)oAuthToken;

@end
