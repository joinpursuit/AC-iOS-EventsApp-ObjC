//
//  MeetupAPI.h
//  Events
//
//  Created by Alex Paul on 5/23/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

#import "Event.h"

@interface MeetupAPI: NSObject

// Making this a class method helps us call the method directly e.g [MeetupAPI searchEventWithKeyword:]
+ (void)searchEventWithKeyword:(NSString *)keyword completionHandler:(void(^)(NSError *error, NSArray <Event *> *events))completion;

@end
