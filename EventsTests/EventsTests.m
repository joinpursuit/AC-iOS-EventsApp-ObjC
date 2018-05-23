//
//  EventsTests.m
//  EventsTests
//
//  Created by Alex Paul on 5/22/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Event.h"

#define APIKEY @"641e35a1d59e162a65215b7a5639e"

@interface EventsTests : XCTestCase

@end

@implementation EventsTests

- (void)testReadingJSONFile {
    // getting the path of "events.json"
    NSString *path = [[NSBundle mainBundle] pathForResource:@"events" ofType:@"json" inDirectory:nil];
    if (path) {
        XCTAssertNotNil(path);
    } else {
        XCTFail(@"Path NOT FOUND");
    }
}

- (void)testCreatingEventModel {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"events" ofType:@"json" inDirectory:nil];
    if (path) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSError *error;
        if (data) {
            NSMutableArray <Event *> *events = [[NSMutableArray alloc] init];
            NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                XCTFail(@"serialization error: %@", error.localizedDescription);
            } else {
                // serialization is successful
                for (NSDictionary *dict in jsonObjects) {
                    Event *event = [[Event alloc] initWithDict:dict];
                    [events addObject:event];
                }
                XCTAssertEqual(events.count, 3);
                
                Event *firstEvent = events[0];
                XCTAssertEqual(firstEvent.eventCreated, @1525190016000);
            }
        } else {
            XCTFail(@"data at file %@ is nil", path);
        }
    } else {
        XCTFail(@"Path NOT FOUND");
    }
}

@end
