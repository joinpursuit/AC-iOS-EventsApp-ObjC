//
//  Event.h
//  Events
//
//  Created by Alex Paul on 5/22/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface Event: NSObject <NSCoding>

// root
@property (nonatomic) NSNumber *eventCreated;
@property (nonatomic) NSNumber *eventId;
@property (nonatomic) NSInteger rsvpCount;
@property (nonatomic, copy) NSString *eventName;
@property (nonatomic, copy) NSString *localDate; 

// venue
@property (nonatomic) NSDictionary *venueDict;
@property (nonatomic) NSNumber *venueId;
@property (nonatomic, copy) NSString *venueName;
@property (nonatomic) CLLocationCoordinate2D coordinate;

// group
@property (nonatomic) NSDictionary *groupDict;
@property (nonatomic) NSNumber *groupCreated;
@property (nonatomic) NSNumber *groupId;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *groupURLName;

// photo
@property (nonatomic) NSDictionary *photoDict;
@property (nonatomic) NSNumber *photoId;
@property (copy, nonatomic) NSString *highResLink;

// iamge
@property (nonatomic) UIImage *image;

// initializer
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
