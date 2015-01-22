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
    UserModel* userModel = [[UserModel alloc] initWithDatabase:@"devoirTest.sqlite"];
    UserModel* failModel = [[UserModel alloc] initWithDatabase:@"NONE"];

    [userModel addUserWithFirstName:@"Alexandre" LastName:@"Dumas" Email:@"thecount@montecristo.com"];
    
    XCTAssertEqualObjects([userModel getFirstName], @"Alexandre");
    XCTAssertEqualObjects([failModel getFirstName], NULL);
    
    XCTAssertEqualObjects([userModel getLastName], @"Dumas");
    XCTAssertEqualObjects([failModel getLastName], NULL);
    
    XCTAssertEqualObjects([userModel getEmail], @"thecount@montecristo.com");
    XCTAssertEqualObjects([failModel getEmail], NULL);
    
    [userModel removeUser];
    
    XCTAssertEqualObjects([userModel getFirstName], NULL);
    XCTAssertEqualObjects([userModel getLastName], NULL);
    XCTAssertEqualObjects([userModel getEmail], NULL);
}

@end
