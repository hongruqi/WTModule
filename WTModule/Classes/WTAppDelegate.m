//
//  WTAppDelegate.m
//  Pods
//
//  Created by walter on 06/08/2017.
//
//

#import "WTAppDelegate.h"
#import "WTModuleLifecycle+AppDelegate.h"

@implementation WTAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return [[WTModuleLifecycle instance] application:application
                                 didFinishLaunchingWithOptions:launchOptions];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //注册远程通知
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[WTModuleLifecycle instance] application:application
       didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[WTModuleLifecycle instance] application:application
       didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[WTModuleLifecycle instance] application:application
                           didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[WTModuleLifecycle instance] application:application
                            didReceiveLocalNotification:notification];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    return [[WTModuleLifecycle instance] application:application
                                          continueUserActivity:userActivity
                                            restorationHandler:restorationHandler];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[WTModuleLifecycle instance] applicationDidEnterBackground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[WTModuleLifecycle instance] applicationDidBecomeActive:application];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[WTModuleLifecycle instance] applicationWillResignActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[WTModuleLifecycle instance] applicationWillTerminate:application];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[WTModuleLifecycle instance] applicationDidReceiveMemoryWarning:application];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[WTModuleLifecycle instance] application:application
                                                       openURL:url
                                             sourceApplication:sourceApplication
                                                    annotation:annotation];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return [[WTModuleLifecycle instance] application:app openURL:url options:options];
    
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler
{
    [[WTModuleLifecycle instance] application:application
                           performActionForShortcutItem:shortcutItem
                                      completionHandler:completionHandler];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[WTModuleLifecycle instance] applicationWillEnterForeground:application];
}

@end
