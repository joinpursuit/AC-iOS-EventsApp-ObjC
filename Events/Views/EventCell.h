//
//  EventCell.h
//  Events
//
//  Created by Alex Paul on 5/24/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventCell : UITableViewCell
- (void)configureViewWithEvent:(Event *)event;
@end
