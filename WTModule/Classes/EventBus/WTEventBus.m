//
//  WTEventBus.m
//  WTModule
//
//  Created by hongru qi on 16/11/2017.
//

#import "WTEventBus.h"
#import "WTEventAction.h"
#import "WTEventDispatch.h"
#import "WTEventQueue.h"

@interface WTEventBus()

@property (nonatomic, strong) dispatch_queue_t  eventBusSerialQueue;
@property (nonatomic, strong) WTEventDispatch  *dispatcher;
@property (nonatomic, strong) WTEventQueue *queue;

@end

@implementation WTEventBus

+ (instancetype)defaultBus
{
    static WTEventBus * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WTEventBus alloc] init];
    });
    
    return sharedInstance;
}

- (void)postEvent:(WTEventItem *)event
{
    [self.queue pushEvent:event];
    [self dispatchEvent];
}

- (void)dispatchEvent
{
    __weak typeof(self) wself = self;
    dispatch_async(self.eventBusSerialQueue, ^{
        __strong typeof(wself) sself = wself;
        WTEventItem *event = [sself.queue pop];
        while (event) {
            [sself.dispatcher dispatchEvent:event];
            event = [sself.queue pop];
        }
    });
}

- (instancetype)init
{
    if (self = [super init]) {
        _eventBusSerialQueue = dispatch_queue_create("com.wteventbus", DISPATCH_QUEUE_SERIAL);
    }
    
    return self;
}

- (void)registerExecuter:(id)executer action:(NSString *)action topic:(NSString *)topic inQueue:(dispatch_queue_t)queue
{
    if (executer) {
        WTEventAction *eAction = [[WTEventAction alloc] init];
        eAction.target = executer;
        eAction.executeQueue = queue;
        
        if (action) {
            eAction.selector = NSSelectorFromString(action);
        }
        
        [self.dispatcher registerAction:eAction topic:topic];
    }
}

- (void)unregisterExecuter:(id)executer action:(NSString *)action topic:(NSString *)topic
{
    if (executer) {
        WTEventAction *eAction = [[WTEventAction alloc] init];
        eAction.target = executer;
        
        if (action) {
            eAction.selector = NSSelectorFromString(action);
        }
        
        [self.dispatcher unregisterAction:eAction topic:topic];
    }
    
}

- (void)registerExecuter:(id)executer action:(NSString *)action topic:(NSString *)topic
{
    [self registerExecuter:executer action:action topic:topic inQueue:nil];
}

- (WTEventQueue *)queue
{
    if (!_queue) {
        _queue = [[WTEventQueue alloc] init];
    }
    return _queue;
}

- (WTEventDispatch *)dispatcher
{
    if (!_dispatcher) {
        _dispatcher = [[WTEventDispatch alloc] init];
    }
    return _dispatcher;
}

@end
