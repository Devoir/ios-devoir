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

- (void)testGetFirstName {
    UserModel* userModel = [[UserModel alloc] initWithDatabase:@"devoirTest.sqlite"];
    XCTAssertEqualObjects([userModel getFirstName], @"Alexandre");
    
    UserModel* failModel = [[UserModel alloc] initWithDatabase:@"NONE"];
    XCTAssertEqualObjects([failModel getFirstName], NULL);
}

- (void)testGetLastName {
    UserModel* userModel = [[UserModel alloc] initWithDatabase:@"devoirTest.sqlite"];
    XCTAssertEqualObjects([userModel getLastName], @"Dumas");
    
    UserModel* failModel = [[UserModel alloc] initWithDatabase:@"NONE"];
    XCTAssertEqualObjects([failModel getLastName], NULL);
}

- (void)testGetEmail {
    UserModel* userModel = [[UserModel alloc] initWithDatabase:@"devoirTest.sqlite"];
    XCTAssertEqualObjects([userModel getEmail], @"thecount@montecristo.com");
    NSLog(@"\n\nLOOK: %@\n\n", [userModel getEmail]);
    
    UserModel* failModel = [[UserModel alloc] initWithDatabase:@"NONE"];
    XCTAssertEqualObjects([failModel getEmail], NULL);
}

@end