//
//  WTEventBus.h
//  WTModule
//
//  Created by hongru qi on 16/11/2017.
//

#import <Foundation/Foundation.h>

@class WTEventItem;
@class WTEventContext;

@interface WTEventBus : NSObject

+ (instancetype _Nonnull )defaultBus;

- (void)postEvent:(nonnull WTEventItem *)event;

- (void)registerExecuter:(nonnull id)executer action:(nonnull NSString *)action topic:(nonnull NSString *)topic;

- (void)registerExecuter:(nonnull id)executer action:(nonnull NSString *)action topic:(nonnull NSString *)topic  inQueue:(nullable dispatch_queue_t)queue;

- (void)unregisterExecuter:(nonnull id)executer action:(nonnull NSString *)action topic:(nonnull NSString *)topic;

@end
