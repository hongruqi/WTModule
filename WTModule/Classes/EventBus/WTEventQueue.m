//
//  WTEventQueue.m
//  WTModule
//
//  Created by hongru qi on 16/11/2017.
//

#import "WTEventQueue.h"
#import "WTEventItem.h"
#import "WTSafeContainer.h"
#import <libkern/OSAtomic.h>

@interface WTEventQueue(){
    OSSpinLock _lock;
}

@property   (nonatomic, strong) NSMutableArray  *queue;

@end

@implementation WTEventQueue

- (instancetype)init
{
    if (self = [super init]) {
        _lock = OS_SPINLOCK_INIT;
    }
    
    return self;
}

- (NSMutableArray *)queue
{
    if (!_queue) {
        _queue = [NSMutableArray array];
    }
    
    return _queue;
}

- (NSUInteger)length
{
    return [self.queue count];
}

- (void)pushEvent:(WTEventItem *)event
{
    if ([event isKindOfClass:[WTEventItem class]]) {
        OSSpinLockLock(&_lock);
        [self.queue wt_addObject:event];
        OSSpinLockUnlock(&_lock);
    }
}

- (WTEventItem *)pop
{
    if (![self.queue isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    WTEventItem *firstEvent = [self.queue firstObject];
    
    if (firstEvent) {
        OSSpinLockLock(&_lock);
        [self.queue removeObjectAtIndex:0];
        OSSpinLockUnlock(&_lock);
    }
    
    return firstEvent;
}

@end
