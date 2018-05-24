//
//  MeetupAPI.m
//  Events
//
//  Created by Alex Paul on 5/23/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeetupAPI.h"
#import "NetworkHelper.h"
#import "APIKeys.h"

@implementation MeetupAPI

// TODO: write a Unit Test for this method
+ (void)searchEventWithKeyword:(NSString *)keyword completionHandler:(void (^)(NSError *, NSArray<Event *> *))completion {
    
    NSString *encodedString = [keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *searchURLString = [NSString stringWithFormat:@"https://api.meetup.com/find/events?key=%@&fields=group_photo&text=%@&lat=40.72&lon=-73.84", API_KEY, encodedString];
    NSURL *url = [NSURL URLWithString:searchURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[NetworkHelper sharedManager] performRequestWithRequest:request completionHandler:^(NSError *error, NSData *data) {
        if (error) {
            completion(error, nil);
        } else {
            if (data) {
                NSMutableArray <Event *> *events = [[NSMutableArray alloc] init];
                NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                if (error) {
                    completion(error, nil);
                } else {
                    for (NSDictionary *dict in jsonObjects) {
                        Event *event = [[Event alloc] initWithDict:dict];
                        [events addObject:event];
                    }
                    completion(nil, events);
                }
            } else {
                completion(error, nil);
            }
        }
    }];
}

@end 
