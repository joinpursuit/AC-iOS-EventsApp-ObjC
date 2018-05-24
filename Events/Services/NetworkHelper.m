//
//  NetworkHelper.m
//  Events
//
//  Created by Alex Paul on 5/23/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkHelper.h"

// class extension
@interface NetworkHelper ()
// private properties and methods
@property (nonatomic) NSURLSession *urlSession;
@end

@implementation NetworkHelper

// [NetworkHelper sharedManager], [NSFileManager sharedManager]
+ (instancetype)sharedManager {
    static NetworkHelper *networkHelper;
    static dispatch_once_t once_token;
    // only run once!!!!!
    dispatch_once(&once_token, ^{
        networkHelper = [[NetworkHelper alloc] init];
    });
    return networkHelper;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // initialize properties
        _urlSession = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
    }
    return self;
}

// HTTP methods: GET, POST
- (void)performRequestWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSError *, NSData *))completion {
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(error, nil);
        } else {
            completion(nil, data);
        }
    }];
    [dataTask resume]; // ALWAYS ADD resume() on the session task
    // or state will be suspended and API call won't happen
}

@end
