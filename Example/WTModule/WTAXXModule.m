//
//  WTAXXModule.m
//  WTModule
//
//  Created by walter on 07/08/2017.
//  Copyright © 2017 lbrsilva-allin. All rights reserved.
//

#import "WTAXXModule.h"
#import "WTModuleLifecycle.h"

@implementation WTAXXModule
+ (void)load
{
    [WTModuleLifecycle registerModuleClass:self config:@{
                                                         } priority:100];
    
}

- (instancetype)initWithConfiguration:(NSDictionary *)configuration
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

- (NSString *)liveShowStart:(NSDictionary *)params
{
    return @"YES";
}

- (void)liveShowEnd:(NSDictionary *)params block:(WTModuleMessagerCallback) block{
    NSString *result = @"success";
    
    //    id result, NSError *error
    block(result, nil);
}

- (void)login:(NSDictionary *)params block:(WTModuleMessagerCallback)block
{
    // requste login
    
}

@end
