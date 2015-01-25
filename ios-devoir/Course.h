//
//  Course.h
//  ios-devoir
//
//  Created by Brent on 1/24/15.
//  Copyright (c) 2015 Brent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

@property int ID;
@property NSString* name;
@property NSString* color;
@property NSString* iCalFeed;
@property NSString* iCalID;
@property int userID;
@property NSDate* lastUpdated;

@end
