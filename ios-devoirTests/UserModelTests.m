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
    
    XCTAssertEqualObjects([userModel getDisplayName], @"Alexandre Dumas");
    XCTAssertEqualObjects([failModel getDisplayName], NULL);
    
    XCTAssertEqualObjects([userModel getEmail], @"thecount@montecristo.com");
    XCTAssertEqualObjects([failModel getEmail], NULL);
    
    XCTAssertEqualObjects([userModel getOAuthToken], @"OAUTH-TOKEN");
    XCTAssertEqualObjects([failModel getOAuthToken], NULL);
    
    XCTAssertEqual([userModel getUserID], 5);
    XCTAssertEqual([failModel getUserID], -1);
    
    [userModel removeUser];
    
    XCTAssertEqualObjects([userModel getDisplayName], NULL);
    XCTAssertEqualObjects([userModel getEmail], NULL);
    XCTAssertEqualObjects([userModel getOAuthToken], NULL);
    XCTAssertEqual([failModel getUserID], -1);
}

@end
