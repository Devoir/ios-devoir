//
//  FakeServer.m
//  ios-devoir
//
//  Created by Brent on 1/24/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import "FakeServer.h"

@implementation FakeServer

static FakeServer *sharedServer = nil;    // static instance variable
+ (FakeServer*) sharedFakeServer
{
    if (sharedServer == nil) {
        sharedServer = [[super allocWithZone:NULL] init];
    }
    return sharedServer;
}

-(NSString*) sendLoginRequestOAuthToken:(NSString*)oAuthToken
{
    return @"{\"DisplayName\": \"Brent Roberts\",\"Email\": \"Brentjoeroberts@gmail.com\",\"OAuthToken\": \"TOKENANDSTUFF\",\"UserID\": 5}";
}

@end
