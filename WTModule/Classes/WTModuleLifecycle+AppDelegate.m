//
//  WTModuleLifecycle+AppDelegate.m
//  Pods
//
//  Created by walter on 06/08/2017.
//
//

#import "WTModuleLifecycle+AppDelegate.h"

@implementation WTModuleLifecycle (AppDelegate)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    SEL sel = _cmd;
    __block BOOL result = NO;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            result = [module application:application didFinishLaunchingWithOptions:launchOptions];
            
            if (!result) {  // stop when got NO
                *stop = YES;
            }
        }
    }];
    
    return result;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module applicationDidBecomeActive:application];
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module applicationWillResignActive:application];
        }
    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module applicationDidEnterBackground:application];
        }
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module applicationWillEnterForeground:application];
        }
    }];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    SEL sel = _cmd;
    __block BOOL result = NO;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            result = [module application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
            
            if (result) {   // stop if handled
                *stop = YES;
            }
        }
    }];
    
    return result;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    SEL sel = _cmd;
    __block BOOL result = NO;
    
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            result = [module application:app openURL:url options:options];
            
            if (result) {   // stop if handled
                *stop = YES;
            }
        }
    }];
    
    return result;
    
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module applicationDidReceiveMemoryWarning:application];
        }
    }];
}

- (void)applicationSignificantTimeChange:(UIApplication *)application
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module applicationSignificantTimeChange:application];
        }
    }];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module application:application didReceiveLocalNotification:notification];
        }
    }];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module application:application didReceiveRemoteNotification:userInfo];
        }
    }];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    SEL sel = _cmd;
    __block BOOL result = NO;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            result = [module application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
            if (result) { // stop if handled
                *stop = YES;
            }
        }
    }];
    
    return result;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module applicationWillTerminate:application];
        }
    }];
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module application:application performFetchWithCompletionHandler:completionHandler];
        }
    }];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    SEL sel = _cmd;
    [self enumerateModulesUsingBlock:^(id module, BOOL *stop) {
        if ([module respondsToSelector:sel]) {
            [module application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }];
}


@end
