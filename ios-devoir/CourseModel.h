//
//  CourseModel.h
//  ios-devoir
//
//  Created by Brent on 1/24/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Constants.h"
#import "Course.h"

@interface CourseModel : NSObject

@property NSString* dbName;

- (id) init;
- (id) initWithDatabase:(NSString*)db;

- (Course*) getCourseByID:(int)ID;
- (NSArray*) getAllCoursesOrderedByName;

- (int) addCourseWithName:(NSString*)name Color:(NSString*)color
                ICalFeed:(NSString*)iCalFeed ICalID:(NSString*)iCalID
                   UserID:(int)userID LastUpdated:(NSDate*)lastUpdated;
- (void) removeCourseByID:(int)ID;
- (void) removeAllCourses;

@end
