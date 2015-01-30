//
//  NSDateFormatter+SIADateFormatter.h
//  SIADateFormatter
//
//  Created by KUROSAKI Ryota on 2013/11/06.
//  Copyright (c) 2013-2015 SI Agency Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (SIADateFormatter)

+ (NSInteger)sia_cacheMaxCount;
+ (void)sia_setCacheMaxCount:(NSInteger)count;
+ (NSDateFormatter *)sia_dateFormatterWithFormat:(NSString *)format
                                          locale:(NSLocale *)locale
                                        timeZone:(NSTimeZone *)timeZone;
+ (NSDateFormatter *)sia_cachedDateFormatterWithFormat:(NSString *)format
                                                locale:(NSLocale *)locale
                                              timeZone:(NSTimeZone *)timeZone;

@end

@interface NSDate (SIADateFormatter)

+ (NSDate *)sia_dateFromString:(NSString *)string
                    withFormat:(NSString *)format;
+ (NSDate *)sia_dateFromString:(NSString *)string
                    withFormat:(NSString *)format
                        locale:(NSLocale *)locale;
+ (NSDate *)sia_dateFromString:(NSString *)string
                    withFormat:(NSString *)format
                        locale:(NSLocale *)locale
                      timeZone:(NSTimeZone *)timeZone;

@end

@interface NSString (SIADateFormatter)

+ (NSString *)sia_stringFromDate:(NSDate *)date
                      withFormat:(NSString *)format;
+ (NSString *)sia_stringFromDate:(NSDate *)date
                      withFormat:(NSString *)format
                          locale:(NSLocale *)locale;
+ (NSString *)sia_stringFromDate:(NSDate *)date
                      withFormat:(NSString *)format
                          locale:(NSLocale *)locale
                        timeZone:(NSTimeZone *)timeZone;

@end
