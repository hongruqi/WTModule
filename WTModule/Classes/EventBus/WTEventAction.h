//
//  WTEventAction.h
//  WTModule
//
//  Created by hongru qi on 16/11/2017.
//

#import <Foundation/Foundation.h>
@class WTEventContext;

@interface WTEventAction : NSObject

@property   (nonatomic, weak)               id target;
@property   (nonatomic, unsafe_unretained)  SEL selector;
@property   (nonatomic, strong)             dispatch_queue_t  executeQueue;

- (void)executeWithContext:(WTEventContext *)context;

@end
