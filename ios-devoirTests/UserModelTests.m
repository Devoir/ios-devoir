//
//  ios_devoirTests.m
//  ios-devoirTests
//
//  Created by Brent on 1/20/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UserModel.h"

@interface UserModelTests : XCTestCase

@end

@implementation UserModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUserModel
{
    UserModel* userModel = [[UserModel alloc] initWithDatabase:@"devoir.sqlite"];
    UserModel* failModel = [[UserModel alloc] initWithDatabase:@"NONE"];

    [userModel addUserWithDisplayName:@"Alexandre Dumas" Email:@"TheCount@MonteCristo.com" OAuthToken:@"OAUTH-TOKEN" UserID: 5];
    
    //test bad database
    User* user = [failModel getUser];
    XCTAssertEqualObjects(user, NULL);

    //test correct database with one user
    user = [userModel getUser];
    
    XCTAssertEqualObjects([user displayName], @"Alexandre Dumas");
    XCTAssertEqualObjects([user email], @"TheCount@MonteCristo.com");
    XCTAssertEqualObjects([user oAuthToken], @"OAUTH-TOKEN");
    XCTAssertEqual([user userID], 5);
    
    //test remove user/empty database
    [userModel removeUser];
    user = [userModel getUser];
    XCTAssertEqualObjects(user, NULL);
}

@end
