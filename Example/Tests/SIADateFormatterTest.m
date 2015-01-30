//
//  SIADateFormatterTest.m
//  SIADateFormatter
//
//  Created by KUROSAKI Ryota on 2015/01/30.
//  Copyright (c) 2015年 KUROSAKI Ryota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import <SIADateFormatter/NSDateFormatter+SIADateFormatter.h>

@interface SIADateFormatterTest : XCTestCase

@end

@implementation SIADateFormatterTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCacheMaxCount {
    // This is an example of a functional test case.
    XCTAssertEqual([NSDateFormatter sia_cacheMaxCount], 5);
    [NSDateFormatter sia_setCacheMaxCount:10];
    XCTAssertEqual([NSDateFormatter sia_cacheMaxCount], 10);
}

- (void)testCacheObject
{
    NSDateFormatter *df1 = [NSDateFormatter sia_cachedDateFormatterWithFormat:@"yyyy" locale:nil timeZone:nil];
    NSDateFormatter *df2 = [NSDateFormatter sia_cachedDateFormatterWithFormat:@"yyyy" locale:nil timeZone:nil];
    
    XCTAssertEqual(df1, df2);
    
    NSDateFormatter *df3 = [NSDateFormatter sia_cachedDateFormatterWithFormat:@"yyyyMMdd" locale:nil timeZone:nil];
    
    XCTAssertNotEqual(df1, df3);


    NSDateFormatter *df4 = [NSDateFormatter sia_cachedDateFormatterWithFormat:@"yyyyMMdd" locale:[NSLocale localeWithLocaleIdentifier:@"en_US"] timeZone:nil];
    NSDateFormatter *df5 = [NSDateFormatter sia_cachedDateFormatterWithFormat:@"yyyyMMdd" locale:[NSLocale localeWithLocaleIdentifier:@"en_US"] timeZone:nil];
    
    XCTAssertEqual(df4, df5);

    NSDateFormatter *df6 = [NSDateFormatter sia_cachedDateFormatterWithFormat:@"yyyyMMdd" locale:[NSLocale localeWithLocaleIdentifier:@"en_GB"] timeZone:nil];

    XCTAssertNotEqual(df4, df6);
}

- (void)testCacheOver
{
    [NSDateFormatter sia_setCacheMaxCount:5];

    NSDateFormatter *df1 = [NSDateFormatter sia_cachedDateFormatterWithFormat:@"y" locale:nil timeZone:nil];
    NSDateFormatter *df2 = [NSDateFormatter sia_cachedDateFormatterWithFormat:@"y" locale:nil timeZone:nil];

    XCTAssertEqual(df1, df2);

    [NSDateFormatter sia_cachedDateFormatterWithFormat:@"yy" locale:nil timeZone:nil];
    [NSDateFormatter sia_cachedDateFormatterWithFormat:@"yyy" locale:nil timeZone:nil];
    [NSDateFormatter sia_cachedDateFormatterWithFormat:@"yyyy" locale:nil timeZone:nil];
    [NSDateFormatter sia_cachedDateFormatterWithFormat:@"yyyyM" locale:nil timeZone:nil];
    [NSDateFormatter sia_cachedDateFormatterWithFormat:@"yyyyMM" locale:nil timeZone:nil];
    
    df2 = [NSDateFormatter sia_cachedDateFormatterWithFormat:@"y" locale:nil timeZone:nil];
    
    XCTAssertNotEqual(df1, df2);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
