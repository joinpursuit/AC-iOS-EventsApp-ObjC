//
//  NetworkHelper.h
//  Events
//
//  Created by Alex Paul on 5/23/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

@interface NetworkHelper: NSObject

+ (instancetype)sharedManager;
- (void)performRequestWithRequest:(NSURLRequest *)request completionHandler:(void(^)(NSError *error, NSData *data))completion;

@end
