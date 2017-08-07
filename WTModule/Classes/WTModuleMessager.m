//
//  WTModuleMessager.m
//  Pods
//
//  Created by walter on 07/08/2017.
//
//

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

@end
