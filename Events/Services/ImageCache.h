//
//  ImageCache.h
//  Events
//
//  Created by Alex Paul on 5/24/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCache: NSObject

+ (id)sharedManager; // singleton
- (UIImage *)getImageForKey:(NSString *)key;

@end
