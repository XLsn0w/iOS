//
//  NSDictionary+Validation.m
//
//  Created by Charles Scalesse on 9/10/13.
//  Copyright (c) 2013 Charles Scalesse. All rights reserved.
//

#import "NSDictionary+Validation.h"

@implementation NSDictionary (Validation)

- (id)objectOrNilForKey:(id)key {
    id object = [self objectForKey:key];
    if (object == [NSNull null]) {
        return nil;
    }
    return object;
}

- (NSString *)stringForKey:(id)key {
    NSString *string = [self objectOrNilForKey:key];
    if ([string isKindOfClass:[NSString class]] && string.length > 0) {
        return string;
    }
    return nil;
}

- (NSString *)stringOrEmptyStringForKey:(id)key {
    NSString *string = [self stringForKey:key];
    if (!string) return @"";
    return string;
}

- (NSDictionary *)dictionaryForKey:(id)key {
    NSDictionary *dictionary = [self objectOrNilForKey:key];
    if ([dictionary isKindOfClass:[NSDictionary class]] && [[dictionary allKeys] count] > 0) {
        return dictionary;
    }
    return nil;
}

- (NSArray *)arrayForKey:(id)key {
    NSArray *array = [self objectOrNilForKey:key];
    if ([array isKindOfClass:[NSArray class]] && [array count] > 0) {
        return [self objectOrNilForKey:key];
    }
    return nil;
}

- (NSNumber *)numberForKey:(id)key {
    NSNumber *number = [self objectOrNilForKey:key];
    if ([number isKindOfClass:[NSNumber class]]) {
        return number;
    }
    return nil;
}

- (NSURL *)urlForKey:(id)key {
    return [NSURL URLWithString:[self stringForKey:key]];
}

- (BOOL)boolForKey:(id)key {
    return [[self objectOrNilForKey:key] boolValue];
}

- (NSDate *)dateForKey:(id)key {
    NSString *string = [self stringForKey:key];
    if (!string) return nil;
    
    if ([string hasSuffix:@"Z"]) {
        string = [[string substringToIndex:(string.length-1)] stringByAppendingString:@"-0000"];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *date = [dateFormatter dateFromString:string];

    return date;
}

- (NSDate *)dateForKeySince1970:(id)key {
    NSNumber *number = [self numberForKey:key];
    if (!number) return nil;
    
    NSTimeInterval timeInterval = [number doubleValue];
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

- (NSDate *)dateForKey:(id)key withFormat:(NSString *)formatString {
    NSString *string = [self stringForKey:key];
    if (!string) return nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    NSDate *date = [dateFormatter dateFromString:string];
    
    return date;
}

@end
