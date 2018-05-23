//
//  MeetupAPITests.m
//  EventsTests
//
//  Created by Alex Paul on 5/23/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkHelper.h"
#import "APIKeys.h"

@interface MeetupAPITests : XCTestCase

@end

@implementation MeetupAPITests

// asynchronous test
- (void)testMeetupAPI {
    // background test requirements
    XCTestExpectation *exp = [self expectationWithDescription:@"events found"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/find/events?key=%@&fields=group_photo&text=swift+programming&lat=40.72&lon=-73.84", API_KEY]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NetworkHelper sharedManager] performRequestWithRequest:request completionHandler:^(NSError *error, NSData *data) {
        if (error) {
            XCTFail(@"request failed with error: %@", error.localizedDescription);
        } else {
            [exp fulfill];
            XCTAssertNotNil(data);
        }
    }];
    
    // background test requirements
    [self waitForExpectations:@[exp] timeout:10.0];
}

@end
