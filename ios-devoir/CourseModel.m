//
//  CourseModel.m
//  ios-devoir
//
//  Created by Brent on 1/24/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import "CourseModel.h"

@implementation CourseModel

@synthesize dbName;

- (id) init
{
    if ((self = [super init]))
    {
        dbName = DB_NAME;
    }
    return self;
}

- (id) initWithDatabase:(NSString*)db
{
    if ((self = [super init]))
    {
        dbName = db;
    }
    return self;
}

- (Course*) getCourseByID:(int)ID
{
    Course* course = NULL;
    NSString* dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:dbName];
    
    sqlite3* db = NULL;
    sqlite3_stmt* stmt =NULL;
    int rc=0;
    rc = sqlite3_open_v2([dbPath UTF8String], &db, SQLITE_OPEN_READONLY , NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString  * query = [NSString stringWithFormat:@"SELECT * from Course WHERE id = %d", ID];
        
        rc =sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, NULL);
        if(rc == SQLITE_OK)
        {
            while (sqlite3_step(stmt) == SQLITE_ROW)
            {
                //GET DATE STUFF!
                int ID =sqlite3_column_int(stmt, 0);
                NSString* name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                NSString* color = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
                NSString* iCalFeed = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
                NSString* iCalID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
                int userID = sqlite3_column_int(stmt, 5);
                //NSDate* lastUpdated = [NSString stringWithUTF8String:(const char *)sqlite3_column_(stmt, 5)];
                
                course = [[Course alloc] init];
                [course setID:ID];
                [course setName:name];
                [course setColor:color];
                [course setICalFeed:iCalFeed];
                [course setICalID:iCalID];
                [course setUserID:userID];

            }
            sqlite3_finalize(stmt);
        }
        else
        {
            NSLog(@"Failed to prepare statement with rc:%d",rc);
        }
        sqlite3_close(db);
    }
    
    return course;
}

- (NSArray*) getAllCoursesOrderedByName
{
    NSMutableArray* courses = [[NSMutableArray alloc] init];
    NSString* dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:dbName];
    
    sqlite3* db = NULL;
    sqlite3_stmt* stmt =NULL;
    int rc=0;
    rc = sqlite3_open_v2([dbPath UTF8String], &db, SQLITE_OPEN_READONLY , NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString  * query = [NSString stringWithFormat:@"SELECT * from Course ORDER BY Name ASC"];
        
        rc =sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, NULL);
        if(rc == SQLITE_OK)
        {
            while (sqlite3_step(stmt) == SQLITE_ROW)
            {
                //GET DATE STUFF!
                int ID = sqlite3_column_int(stmt, 0);
                NSString* name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                NSString* color = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
                NSString* iCalFeed = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
                NSString* iCalID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
                int userID = sqlite3_column_int(stmt, 5);
                //NSDate* lastUpdated = [NSString stringWithUTF8String:(const char *)sqlite3_column_(stmt, 5)];
                
                Course* course = [[Course alloc] init];
                [course setID:ID];
                [course setName:name];
                [course setColor:color];
                [course setICalFeed:iCalFeed];
                [course setICalID:iCalID];
                [course setUserID:userID];
                
                [courses addObject:course];
                
            }
            sqlite3_finalize(stmt);
        }
        else
        {
            NSLog(@"Failed to prepare statement with rc:%d",rc);
        }
        sqlite3_close(db);
    }
    
    return [courses copy];
}

- (int) addCourseWithName:(NSString *)name Color:(NSString *)color ICalFeed:(NSString *)iCalFeed
                   ICalID:(NSString *)iCalID UserID:(int)userID LastUpdated:(NSDate *)lastUpdated
{
    NSString* dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:dbName];
    
    sqlite3* db = NULL;
    int rc=0;
    rc = sqlite3_open_v2([dbPath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE , NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString * query  = [NSString
                             stringWithFormat:@"INSERT INTO Course"
                             "(Name, Color, iCalFeed, iCalID, UserID, LastUpdated)"
                             "VALUES (\"%@\",\"%@\",\"%@\",\"%@\",%d,\"%@\")",
                             name, color, iCalFeed, iCalID, userID, lastUpdated];
        
        //NSLog(@"QUERY: %@", query);
        char * errMsg;
        rc = sqlite3_exec(db, [query UTF8String] ,NULL,NULL,&errMsg);
        if(SQLITE_OK != rc)
        {
            NSLog(@"Failed to insert record  rc:%d, msg=%s",rc,errMsg);
        }
        sqlite3_close(db);
    }
    
    return rc;
}

- (void) removeCourseByID:(int)ID
{
    NSString* dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:dbName];
    
    sqlite3* db = NULL;
    int rc=0;
    rc = sqlite3_open_v2([dbPath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE , NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString * query  = [NSString stringWithFormat:@"DELETE FROM Course WHERE id = %d", ID];
        char * errMsg;
        rc = sqlite3_exec(db, [query UTF8String] ,NULL,NULL,&errMsg);
        if(SQLITE_OK != rc)
        {
            NSLog(@"Failed to delete record  rc:%d, msg=%s",rc,errMsg);
        }
        sqlite3_close(db);
    }
}

- (void) removeAllCourses
{
    NSString* dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:dbName];
    
    sqlite3* db = NULL;
    int rc=0;
    rc = sqlite3_open_v2([dbPath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE , NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString * query  = [NSString stringWithFormat:@"DELETE FROM Course"];
        char * errMsg;
        rc = sqlite3_exec(db, [query UTF8String] ,NULL,NULL,&errMsg);
        if(SQLITE_OK != rc)
        {
            NSLog(@"Failed to delete record  rc:%d, msg=%s",rc,errMsg);
        }
        sqlite3_close(db);
    }
}

@end
