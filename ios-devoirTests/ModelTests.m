//
//  ios_devoirTests.m
//  ios-devoirTests
//
//  Created by Brent on 1/20/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CourseModel.h"
#import "UserModel.h"

@interface ModelTests : XCTestCase

@end

@implementation ModelTests

- (void) setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void) tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//TEST DATE AFTER DATE STUFF IS IMPLEMENTED
- (void) testCourseModel
{
    CourseModel* courseModel = [[CourseModel alloc] initWithDatabase:@"devoir-test.sqlite"];
    CourseModel* failModel = [[CourseModel alloc] initWithDatabase:@"NONE"];
    
    //TEST BAD DATABASE
    [failModel addCourseWithName:@"David Foster Wallace"
                             Color:@"BLUE"
                          ICalFeed:@"iCALFEEEED"
                            ICalID:@"IDIDID"
                            UserID:4
                       LastUpdated:[NSDate date]];
    Course* course = [failModel getCourseByID:0];
    XCTAssertEqualObjects(course, NULL);

    //add courses
    [courseModel addCourseWithName:@"David Foster Wallace"
                             Color:@"BLUE"
                          ICalFeed:@"iCALFEEEED"
                            ICalID:@"IDIDID"
                            UserID:4
                       LastUpdated:[NSDate date]];
    
    [courseModel addCourseWithName:@"G"
                             Color:@"GREEN"
                          ICalFeed:@"iCAL"
                            ICalID:@"FOUR"
                            UserID:4
                       LastUpdated:[NSDate date]];
    
    [courseModel addCourseWithName:@"A"
                             Color:@"APPLE"
                          ICalFeed:@"iCALAPPPP"
                            ICalID:@"AND"
                            UserID:4
                       LastUpdated:[NSDate date]];
    
    //test get course by id
    course = [courseModel getCourseByID:1];
    XCTAssertEqualObjects([course name], @"David Foster Wallace");
    XCTAssertEqualObjects([course color], @"BLUE");
    XCTAssertEqualObjects([course iCalFeed], @"iCALFEEEED");
    XCTAssertEqualObjects([course iCalID], @"IDIDID");
    XCTAssertEqual([course userID], 4);
    
    
    //test get all courses ordered by name
    NSArray* courses = [courseModel getAllCoursesOrderedByName];
    
    course = [courses objectAtIndex:0];
    XCTAssertEqualObjects([course name], @"A");
    XCTAssertEqualObjects([course color], @"APPLE");
    XCTAssertEqualObjects([course iCalFeed], @"iCALAPPPP");
    XCTAssertEqualObjects([course iCalID], @"AND");
    XCTAssertEqual([course userID], 4);
    
    course = [courses objectAtIndex:2];
    XCTAssertEqualObjects([course name], @"G");
    XCTAssertEqualObjects([course color], @"GREEN");
    XCTAssertEqualObjects([course iCalFeed], @"iCAL");
    XCTAssertEqualObjects([course iCalID], @"FOUR");
    XCTAssertEqual([course userID], 4);

    //test remove
    int testRemoveID = [course ID];
    [courseModel removeCourseByID:testRemoveID];
    
    course = [courseModel getCourseByID:2];
    XCTAssertEqualObjects(course, NULL);

    [courseModel removeAllCourses];
}

- (void) testUserModel
{
    UserModel* userModel = [[UserModel alloc] initWithDatabase:@"devoir-test.sqlite"];
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
