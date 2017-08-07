//
//  WTModuleLifecycle.h
//  Pods
//
//  Created by walter on 05/08/2017.
//
//

#import <Foundation/Foundation.h>
@protocol WTModuleLifecycleDelegate;

@interface WTModuleLifecycle : NSObject

+ (instancetype)instance;

+ (void)registerModuleClass:(Class <WTModuleLifecycleDelegate>)moduleClass
                     config:(NSDictionary *)config
                   priority:(NSInteger)priority;

- (id)moduleInstanceByName:(NSString *)moduleName;

- (void)enumerateModulesUsingBlock:(__attribute__((noescape)) void (^)(id module, BOOL *stop))block;

@end
