//
//  WTEventAction.m
//  WTModule
//
//  Created by hongru qi on 16/11/2017.
//

#import "WTEventAction.h"
#import "WTEventContext.h"

@implementation WTEventAction

- (void)executeWithContext:(WTEventContext *)context
{
    // 默认Protocol里的那个方法
    if (nil == self.selector) {
        self.selector = @selector(executeWithContext:);
    }
    if (self.target && [self.target respondsToSelector:self.selector]) {
        // 默认主线程
        if (nil == self.executeQueue) {
            self.executeQueue = dispatch_get_main_queue();
        }
        
        __block NSMutableArray *holder = [[NSMutableArray alloc] init];
        if (context.event) {
            [holder addObject:context.event];
        }
        if (context.poster) {
            [holder addObject:context.poster];
        }
        if (context.target) {
            [holder addObject:context.target];
        }
        
        //线程 问题
        if([NSThread isMainThread]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.target performSelector:self.selector withObject:context];
#pragma clang diagnostic pop
        }else {
            __weak typeof(self) wself = self;
            dispatch_sync(self.executeQueue, ^{
                __strong typeof(wself) sself = wself;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [sself.target performSelector:sself.selector withObject:context];
#pragma clang diagnostic pop
            });
        }
    }
    
}

@end
