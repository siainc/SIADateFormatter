//
//  NSDateFormatter+SIADateFormatter.m
//  SIADateFormatter
//
//  Created by KUROSAKI Ryota on 2013/11/06.
//  Copyright (c) 2013-2015 SI Agency Inc. All rights reserved.
//

#if !__has_feature(objc_arc)
#error This code needs compiler option -fobjc_arc
#endif

#import "NSDateFormatter+SIADateFormatter.h"

static NSMutableArray *_siadateformatter_pool;
static NSInteger _siadateformatter_cacheMaxCount;
static dispatch_once_t _siadateformatter_onceToken;

@implementation NSDateFormatter (SIADateFormatter)

+ (NSInteger)sia_cacheMaxCount
{
    dispatch_once(&_siadateformatter_onceToken, ^{
        _siadateformatter_cacheMaxCount = 5;
    });
    return _siadateformatter_cacheMaxCount;
}

+ (void)sia_setCacheMaxCount:(NSInteger)count
{
    dispatch_once(&_siadateformatter_onceToken, ^{
        // nothig to do
    });
    _siadateformatter_cacheMaxCount = count;
}

+ (NSDateFormatter *)sia_dateFormatterWithFormat:(NSString *)format
                                          locale:(NSLocale *)locale
                                        timeZone:(NSTimeZone *)timeZone
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    formatter.locale = locale;
    formatter.timeZone = timeZone;
    return formatter;
}

+ (NSDateFormatter *)sia_cachedDateFormatterWithFormat:(NSString *)format
                                                locale:(NSLocale *)locale
                                              timeZone:(NSTimeZone *)timeZone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _siadateformatter_pool = [NSMutableArray arrayWithCapacity:[self sia_cacheMaxCount] + 1];
    });
    
    if (!locale) {
        locale = [NSLocale currentLocale];
    }
    if (!timeZone) {
        timeZone = [NSTimeZone localTimeZone];
    }
    
    NSDateFormatter *dateFormatter = nil;
    for (NSDateFormatter *df in _siadateformatter_pool) {
        if ([df.dateFormat isEqualToString:format] &&
            [df.locale.localeIdentifier isEqualToString:locale.localeIdentifier] &&
            df.timeZone.secondsFromGMT == timeZone.secondsFromGMT) {
            dateFormatter = df;
            break;
        }
    }
    if (!dateFormatter) {
        dateFormatter = [self sia_dateFormatterWithFormat:format locale:locale timeZone:timeZone];
    }
    
    [_siadateformatter_pool removeObject:dateFormatter];
    [_siadateformatter_pool addObject:dateFormatter];
    if (_siadateformatter_pool.count > [self sia_cacheMaxCount]) {
        if (_siadateformatter_pool.firstObject) {
            [_siadateformatter_pool removeObjectAtIndex:0];
        }
    }
    return dateFormatter;
}

@end

@implementation NSDate (SIADateFormatter)

+ (NSDate *)sia_dateFromString:(NSString *)string
                    withFormat:(NSString *)format
{
    return [self sia_dateFromString:string withFormat:format locale:nil];
}

+ (NSDate *)sia_dateFromString:(NSString *)string
                    withFormat:(NSString *)format
                        locale:(NSLocale *)locale
{
    return [self sia_dateFromString:string withFormat:format locale:locale timeZone:nil];
}

+ (NSDate *)sia_dateFromString:(NSString *)string
                    withFormat:(NSString *)format
                        locale:(NSLocale *)locale
                      timeZone:(NSTimeZone *)timeZone
{
    NSDateFormatter *formatter = [NSDateFormatter sia_cachedDateFormatterWithFormat:format
                                                                             locale:locale
                                                                           timeZone:timeZone];
    return [formatter dateFromString:string];
}

@end

@implementation NSString (SIADateFormatter)

+ (NSString *)sia_stringFromDate:(NSDate *)date
                      withFormat:(NSString *)format
{
    return [self sia_stringFromDate:date withFormat:format locale:nil];
}

+ (NSString *)sia_stringFromDate:(NSDate *)date
                      withFormat:(NSString *)format
                          locale:(NSLocale *)locale
{
    return [self sia_stringFromDate:date withFormat:format locale:locale timeZone:nil];
}

+ (NSString *)sia_stringFromDate:(NSDate *)date
                      withFormat:(NSString *)format
                          locale:(NSLocale *)locale
                        timeZone:(NSTimeZone *)timeZone
{
    NSDateFormatter *formatter = [NSDateFormatter sia_cachedDateFormatterWithFormat:format
                                                                             locale:locale
                                                                           timeZone:timeZone];
    return [formatter stringFromDate:date];
}

@end

