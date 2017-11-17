//
//  WTEventDispatch.m
//  WTModule
//
//  Created by hongru qi on 16/11/2017.
//

#import "WTEventDispatch.h"
#import "WTEventItem.h"
#import "WTSafeContainer.h"
#import "WTEventAction.h"

@interface WTEventDispatch()

@property (nonatomic, strong) NSMutableDictionary *dispatchPool;

@end

@implementation WTEventDispatch

- (void)dispatchEvent:(WTEventItem *)event
{
    NSArray *topicActions = [self.dispatchPool wt_objectForKey:event.topic];

    for (WTEventAction *action in topicActions) {
        if (action && [action isKindOfClass:[WTEventAction class]]) {
            [action executeWithContext:event.context];
        }
    }
}

- (void)registerAction:(WTEventAction *)action topic:(NSString *)topic
{
    [self addAction:action topic:topic];
}

- (void)unregisterAction:(WTEventAction *)action topic:(NSString *)topic
{
    [self removeAction:action topic:topic];
}
- (void)addAction:(WTEventAction *)action topic:(NSString *)topic
{
    NSMutableArray *mutableActions = nil;
    NSArray *actions = [self.dispatchPool wt_objectForKey:topic];
    if (nil == actions) {
        mutableActions = [[NSMutableArray alloc] init];
    }else if ([actions isKindOfClass:[NSMutableArray class]]) {
        mutableActions = (NSMutableArray *)actions;
    }else if ([actions isKindOfClass:[NSArray class]]) {
        mutableActions = [actions mutableCopy];
    }else {
        mutableActions = [[NSMutableArray alloc] init];
    }
    
    [mutableActions addObject:action];
    [self.dispatchPool setValue:mutableActions forKey:topic];
}

- (void)removeAction:(WTEventAction *)action topic:(NSString *)topic
{
    NSArray *topicActions = [self.dispatchPool wt_objectForKey:topic];
    NSMutableArray *mutableActions = (NSMutableArray *)topicActions;
    
    for (WTEventAction *eventAction in mutableActions) {
        if (eventAction && [eventAction isKindOfClass:[WTEventAction class]]) {
            if([action.target isEqual:eventAction.target] && [NSStringFromSelector(action.selector) isEqualToString:NSStringFromSelector(eventAction.selector)]){
                [mutableActions removeObject:eventAction];
            }
        }
    }
    
    [self.dispatchPool setValue:mutableActions forKey:topic];
}

- (NSMutableDictionary *)dispatchPool
{
    if (!_dispatchPool) {
        _dispatchPool = [NSMutableDictionary dictionary];
    }

    return _dispatchPool;
}

@end
