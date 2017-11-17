//
//  WTEventDispatch.h
//  WTModule
//
//  Created by hongru qi on 16/11/2017.
//

#import <Foundation/Foundation.h>

@class WTEventAction;
@class WTEventItem;

@interface WTEventDispatch : NSObject

- (void)registerAction:(WTEventAction *)action topic:(NSString *)topic;

- (void)unregisterAction:(WTEventAction *)action topic:(NSString *)topic;

- (void)dispatchEvent:(WTEventItem *)event;

@end
