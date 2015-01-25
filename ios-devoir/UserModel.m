//
//  UserAccess.m
//  ios-devoir
//
//  Created by Brent on 1/24/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

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

- (User*) getUser
{
    User* user = [[User alloc] init];
    
    [user setDisplayName:[self getDisplayName]];
    [user setEmail:[self getEmail]];
    [user setOAuthToken:[self getOAuthToken]];
    [user setUserID:[self getUserID]];
    
    return user;
}

- (NSString*) getDisplayName
{
    NSString* displayName = NULL;
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
        NSString  * query = @"SELECT DisplayName from User";
        
        rc =sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, NULL);
        if(rc == SQLITE_OK)
        {
            while (sqlite3_step(stmt) == SQLITE_ROW)
            {
                
                displayName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            }
            sqlite3_finalize(stmt);
        }
        else
        {
            NSLog(@"Failed to prepare statement with rc:%d",rc);
        }
        sqlite3_close(db);
    }
    
    return displayName;
}

- (NSString*) getEmail
{
    NSString* email = NULL;
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
        NSString  * query = @"SELECT Email from User";
        
        rc =sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, NULL);
        if(rc == SQLITE_OK)
        {
            while (sqlite3_step(stmt) == SQLITE_ROW)
            {
                
                email = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            }
            sqlite3_finalize(stmt);
        }
        else
        {
            NSLog(@"Failed to prepare statement with rc:%d",rc);
        }
        sqlite3_close(db);
    }
    
    return [email lowercaseString];
}

- (NSString*) getOAuthToken
{
    NSString* userImageUrl = NULL;
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
        NSString  * query = @"SELECT OAuthToken from User";
        
        rc =sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, NULL);
        if(rc == SQLITE_OK)
        {
            while (sqlite3_step(stmt) == SQLITE_ROW)
            {
                
                userImageUrl = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            }
            sqlite3_finalize(stmt);
        }
        else
        {
            NSLog(@"Failed to prepare statement with rc:%d",rc);
        }
        sqlite3_close(db);
    }
    
    return userImageUrl;
}

- (int) getUserID
{
    int userID = -1;
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
        NSString  * query = @"SELECT UserID from User";
        
        rc =sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, NULL);
        if(rc == SQLITE_OK)
        {
            while (sqlite3_step(stmt) == SQLITE_ROW)
            {
                
                userID = sqlite3_column_int(stmt, 0);
            }
            sqlite3_finalize(stmt);
        }
        else
        {
            NSLog(@"Failed to prepare statement with rc:%d",rc);
        }
        sqlite3_close(db);
    }
    
    return userID;
}

- (int) addUserWithDisplayName:(NSString *)displayName Email:(NSString *)email OAuthToken:(NSString *)oAuthToken UserID:(int)userID
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
                             stringWithFormat:@"INSERT INTO User (DisplayName, Email, OAuthToken, UserID) VALUES (\"%@\",\"%@\",\"%@\",%d)",
                             displayName, email, oAuthToken, userID];
        
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

- (void) removeUser
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
        NSString * query  = [NSString stringWithFormat:@"DELETE FROM User"];
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