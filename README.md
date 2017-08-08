# WTModule
##提供功能
- 组件生命周期
- 以及组件间通信

## Requirements
Xcode7 later，iOS 8
## Installation

WTModule is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "WTModule"
```

## Author
walter

## License

MIT

# iOS 组件开发
##背景
 关于组件化开发，经历过几家不同公司，正好处于不同的开发阶段。
第一家港股上市公司，移动端业务线很多，主要是即时通讯功能，类似与微博的社区功能，企业ERP功能，视频教育功能，开始各条业务线独立，相互调用只能通过彼此提供静态库或者framework进行，每次升级都需要重新集成，比较麻烦，问题也很多，问题反馈解决时间也很漫长。之后公司后台业务重构，移动端随之进行组件化开发，经历了整个过程。
第二家公司，国内知名互联企业，进入开发组时，已经完成组件化工作，各个业务人员在自己的业务线上进行开发，每条业务线独立提测，在这样的业务线上工作，可以更专一的完成个人负责的业务，效率更高。
目前所在公司，没有进行组件化，业务耦合严重，全局变量使用频繁，经常会因为A业务被修改，导致B业务产生bug。现阶段开始进行组件化。

##个人思考： 什么时候做组件开发
- 项目管理：项目的业务线超过2条以上，需要独立拆分。随着业务的拆分，对应的业务组件也就很自然的独立出来。
- 人员管理：随着人员的增加，过多人对同一块代码的进行修改，导致bug的可能性上升，这时候需要对人员和其维护的功能需要进行重新分配。
- 测试维度：随着项目的业务量增大，不做组件化，就很难做单元测试。每个小功能修改，测试都需要对App进行测试，严重增加测试工作量。
- 综上：当你的App业务之间交叉耦合，bug率难以下降，测试每天做大量重复工作。开发人员之间修改项目影响时，你需要考虑进行组件化。

## 如何做组件开发
使用CocoaPods进行独立组件开发
 [Cocoapods 发布私有pod组件](http://www.jianshu.com/p/80eeb5bc8834)

## 组件划分
![架构图.png](http://upload-images.jianshu.io/upload_images/901318-be6b6895fec095e4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
###公共组件：
- 埋点组件
- Common组件（聚合工具类）
- 启动组件
- 性能监控组件
- 定位组件
- 图片处理组件
- UIKit封装和扩展组件
- 业务生命周期及通信组件
###网络组件：
- 基础网络组件 基于AFNetworking进行封装，提供JSON转Model，和缓存功能
- DNS 加速组件
###持久化组件
- 基于FMDB进行封装组件
###第三方业务组件，在第三方SDK基础上进行适配
- 分享组件
- 推送组件
###基础业务组件
- User组件，保存用户信息，登陆，登出状态

##组件生命周期管理
- 组件的生命周期，与App的生命周期应该保持一致。
![组件生命周期.png](http://upload-images.jianshu.io/upload_images/901318-07fec64bc877746a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 源码
```Objc

#WTAppDelegate.h

@interface WTAppDelegate : UIResponder<UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
#WTAppDelegate.m
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

```
##组件间通信
>现状：目前非常流行的方式为，蘑菇街的解决方案，通过路由协议，实现全部App的内页面间跳转。不过我们没有选择这样做。
 
- 首先，我们定义件间： 有与App相同的生命周期，可以独立编译，功能独立，对外提供统一接口。

>通过上面的定义，我们会发现路由协议不适用于我们对组件的定义。
分析：页面路由，打破了件间的独立性，虽然是通过统一的协议进行访问。但是这样就存在一个问题。A组件的一个子界面，可以访问B组件的子界面。这对我们对组件的理解有些矛盾。A组件的子界面需要调用B的子界面，需要通过B组件提供的接口调用。

##我们的实现
1. 注册组件由WTModuleLifecycle最为媒介持有组件
2. 通过统一API调用，实现组件间通信


###代码
```Objc
#import "WTModuleMessager.h"
#import <objc/message.h>
#import "WTModuleLifecycle.h"

@interface WTModuleMessager()

@property (nonatomic, strong) NSMutableArray *services;

@end

@implementation WTModuleMessager

+ (instancetype)instance
{
    static dispatch_once_t oncePredicate;
    static WTModuleMessager *instance;
    dispatch_once(&oncePredicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _services = [NSMutableArray array];
    }
    return self;
}

+ (id)performAPI:(NSString *)moduleName methodName:(NSString *)methodName withParams:(NSDictionary *)params
{
    Class targetClass = [WTModuleMessager serviceClassFromString:moduleName];
    SEL targetSelector = [WTModuleMessager selectorFromString:methodName hasCallBack:NO];
    if (![WTModuleMessager validateClass:targetClass selector:targetSelector]) {
        NSAssert(targetClass, @"%@ 名称不规范",moduleName);
    }
    
    //    id targetOpenService = [[targetClass alloc]init];
    id targetOpenService = [[WTModuleLifecycle instance] moduleInstanceByName:NSStringFromClass(targetClass)];
    if ([targetOpenService respondsToSelector:targetSelector]) {
        return ((id (*)(id, SEL, id))objc_msgSend)(targetOpenService, targetSelector, params);
    } else {
        NSAssert(targetClass, @"%@ 找不到对应的类方法",methodName);
        return nil;
    }
}

+ (BOOL)performAPI:(NSString *)moduleName methodName:(NSString *)methodName withParams:(NSDictionary *)params block:(WTModuleMessagerCallback)block
{
    Class targetClass = [WTModuleMessager serviceClassFromString:moduleName];
    SEL targetSelector = [WTModuleMessager selectorFromString:methodName hasCallBack:YES];
    if (![WTModuleMessager validateClass:targetClass selector:targetSelector]) {
        NSAssert(targetClass, @"%@ 名称不规范",moduleName);
    }
    
    id targetOpenService = [[targetClass alloc]init];
    if ([targetOpenService respondsToSelector:targetSelector]) {
        [[WTModuleMessager instance].services addObject:targetOpenService];
        return ((BOOL (*)(id, SEL, id, WTModuleMessagerCallback))objc_msgSend)(targetOpenService, targetSelector, params,[WTModuleMessager callbackBlock:block openService:targetOpenService]);
    } else {
        NSAssert(targetClass, @"%@ 找不到对应的类方法",methodName);
        return NO;
    }
}

+ (WTModuleMessagerCallback)callbackBlock:(WTModuleMessagerCallback)callbackBlock openService:(NSObject *)openService
{
    WTModuleMessagerCallback block = ^(NSError *error, id result){
        [[WTModuleMessager instance].services removeObject:openService];
        callbackBlock(error,result);
    };
    return [block copy];
}

+ (BOOL)validateClass:(Class)targetClass selector:(SEL)targetSelector
{
    if (targetClass && targetSelector) {
        return YES;
    }
    return NO;
}

+ (Class)serviceClassFromString:(NSString *)moduleName
{
    NSArray *pathArray = [moduleName componentsSeparatedByString:@"/"];
    NSMutableString *serviceClassMS = [[NSMutableString alloc] initWithString:@"WT"];
    [serviceClassMS appendString:[NSString stringWithFormat:@"%@%@", [[pathArray.firstObject substringToIndex:1] capitalizedString], [pathArray.firstObject substringFromIndex:1]]];
    [serviceClassMS appendString:@"Module"];
    return NSClassFromString(serviceClassMS);
}

+ (SEL)selectorFromString:(NSString *)methodName hasCallBack:(BOOL)hasCallBack
{
    NSArray *pathArray = [methodName componentsSeparatedByString:@"/"];
    NSMutableString *serviceClassMS = [[NSMutableString alloc] init];
    [serviceClassMS appendString:[NSString stringWithFormat:@"%@%@", [[pathArray.firstObject substringToIndex:1] lowercaseString], [pathArray.firstObject substringFromIndex:1]]];
    
    NSString *selectorString = nil;
    if (hasCallBack) {
        selectorString = [NSString stringWithFormat:@"%@:block:",serviceClassMS];
    } else {
        selectorString = [NSString stringWithFormat:@"%@:",serviceClassMS];
    }
    return NSSelectorFromString(selectorString);
}
```

