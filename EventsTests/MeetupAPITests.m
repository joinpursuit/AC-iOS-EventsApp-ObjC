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
#import "Event.h"

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

- (void)testSearchEvent {
    // background test requirements
    XCTestExpectation *exp = [self expectationWithDescription:@"events found"];
    
    NSString *keyword = @"memorial day parade";
    NSString *encodedString = [keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *searchURLString = [NSString stringWithFormat:@"https://api.meetup.com/find/events?key=%@&fields=group_photo&text=%@&lat=40.72&lon=-73.84", API_KEY, encodedString];
    NSURL *url = [NSURL URLWithString:searchURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[NetworkHelper sharedManager] performRequestWithRequest:request completionHandler:^(NSError *error, NSData *data) {
        if (error) {
            XCTFail(@"request error: %@", error.localizedDescription);
        } else {
            if (data) {
                NSMutableArray <Event *> *events = [[NSMutableArray alloc] init];
                NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                if (error) {
                    XCTFail(@"serialization error: %@", error.localizedDescription);
                } else {
                    for (NSDictionary *dict in jsonObjects) {
                        Event *event = [[Event alloc] initWithDict:dict];
                        [events addObject:event];
                    }
                    // background test requirements
                    [exp fulfill];
                    XCTAssertGreaterThan(events.count, 0);
                }
            } else {
                XCTFail(@"data is nil");
            }
        }
    }];
    
    // background test requirements
    [self waitForExpectations:@[exp] timeout:10.0];
}

- (void)testCreateUpdateRSVP {
    // background test requirements
    XCTestExpectation *exp = [self expectationWithDescription:@"events found"];

    NSString *eventId = @"250854006";
    NSString *rsvp = @"no"; // no, yes, waitlist
    NSString *createUpdateRSVPURLString = [NSString stringWithFormat:@"https://api.meetup.com/2/rsvp?key=%@&event_id=%@&rsvp=%@", API_KEY, eventId, rsvp];
    NSURL *url = [NSURL URLWithString:createUpdateRSVPURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";

    [[NetworkHelper sharedManager] performRequestWithRequest:request completionHandler:^(NSError *error, NSData *data) {
        if (error) {
            XCTFail(@"request error: %@", error.localizedDescription);
        } else {
            [exp fulfill];
            XCTAssertNotNil(data);
        }
    }];
    
    // background test requirements
    [self waitForExpectations:@[exp] timeout:10.0];

}

@end
