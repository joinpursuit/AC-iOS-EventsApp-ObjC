//
//  PersistenceDataTests.m
//  EventsTests
//
//  Created by Alex Paul on 5/24/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Event.h"

@interface PersistenceDataTests : XCTestCase

@end

@implementation PersistenceDataTests

- (void)testSavingEventModels {
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
                
                // Save Events
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = paths.firstObject;
                NSString *filename = @"filename.plist";
                NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
                
                BOOL archived = [NSKeyedArchiver archiveRootObject:events toFile:path];
                if (!archived) {
                    XCTFail(@"failed to archive");
                } else {
                    XCTAssertTrue(archived);
                }
                
            }
        } else {
            XCTFail(@"data at file %@ is nil", path);
        }
    } else {
        XCTFail(@"Path NOT FOUND");
    }
}

- (void)testLoadingEventsFromDocuments {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject;
    NSString *filename = @"filename.plist";
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
    
    NSArray <Event *> *events = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    if(!events)
        XCTFail(@"failed to unarchive events");
    
    XCTAssertEqual(events.count, 3);
}

- (void)testGetDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject;
    NSString *substring = @"Documents";
    BOOL found = [documentsDirectory containsString:substring];
    
    XCTAssertTrue(found);
}

- (void)testCreateFilepath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject;
    NSString *substring = @"filename";
    NSString *filename = @"filename.plist";
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
    BOOL found = [path containsString:substring];
    
    XCTAssertTrue(found);
}

- (void)testSavingImage {
    // construct image data from image url
    NSString *imageURLString = @"https://secure.meetupstatic.com/photos/event/9/a/c/6/highres_463119622.jpeg";
    NSURL *url = [NSURL URLWithString:imageURLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    NSData *imageData = UIImagePNGRepresentation(image);
    
    // file path using photo id
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject;
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"463119622"]; // use the photo id as the path component
    
    // write image data to the file path
    BOOL fileWasWritten = [imageData writeToFile:path atomically:YES];
    
    // test
    XCTAssertTrue(fileWasWritten);
}

- (void)testDeleteImage {
    // file path using photo id
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject;
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"463119622"]; // use the photo id as the path component
    
    if (path) {
        NSError *error;
        BOOL fileRemoved = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        if (error)
            XCTFail(@"removing error: %@", error.localizedDescription);
        XCTAssertTrue(fileRemoved);
    } else {
        XCTFail(@"path is nil");
    }
}

- (void)testLoadImage {
    // file path using photo id
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject;
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"463119622"]; // use the photo id as the path component
    
    // read contents at path and create UIImage
    NSData *imageData = [[NSFileManager defaultManager] contentsAtPath:path];
    if (!imageData)
        XCTFail(@"image data is nil");
    UIImage *image = [UIImage imageWithData:imageData];
    
    // test
    XCTAssertNotNil(image);
}

@end
