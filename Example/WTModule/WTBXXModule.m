//
//  WTBXXModule.m
//  WTModule
//
//  Created by walter on 07/08/2017.
//  Copyright © 2017 lbrsilva-allin. All rights reserved.
//

#import "WTBXXModule.h"
#import "WTModuleLifecycle.h"

@implementation WTBXXModule

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
@end
