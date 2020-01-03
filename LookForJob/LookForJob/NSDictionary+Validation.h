//
//  NSDictionary+Validation.h
//
//  Created by Charles Scalesse on 9/10/13.
//  Copyright (c) 2013 Charles Scalesse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Validation)

- (id)objectOrNilForKey:(id)key;
- (NSString *)stringForKey:(id)key;
- (NSString *)stringOrEmptyStringForKey:(id)key;
- (NSDictionary *)dictionaryForKey:(id)key;
- (NSArray *)arrayForKey:(id)key;
- (NSNumber *)numberForKey:(id)key;
- (NSURL *)urlForKey:(id)key;
- (BOOL)boolForKey:(id)key;
- (NSDate *)dateForKey:(id)key;     // expects a string in ISO8601 format
- (NSDate *)dateForKeySince1970:(id)key; // expects a number representing seconds since 1970
- (NSDate *)dateForKey:(id)key withFormat:(NSString *)formatString;

@end