//
//  WTEventQueue.h
//  WTModule
//
//  Created by hongru qi on 16/11/2017.
//

#import <Foundation/Foundation.h>
@class WTEventItem;

@interface WTEventQueue : NSObject

/**
 * The length of the event queue.
 */
- (NSUInteger)length;

/**
 * Add a event to queue.
 */
- (void)pushEvent:(WTEventItem *)event;

/**
 * Get a event
 */
- (WTEventItem *)pop;
@end
