//
//  WTModuleMessager.h
//  Pods
//
//  Created by walter on 07/08/2017.
//
//

#import <Foundation/Foundation.h>

typedef void (^WTModuleMessagerCallback)(id result, NSError *error);

@interface WTModuleMessager : NSObject

+ (id)performAPI:(NSString *)moduleName methodName:(NSString *)methodName withParams:(NSDictionary *)params;

+ (BOOL)performAPI:(NSString *)moduleName methodName:(NSString *)methodName withParams:(NSDictionary *)params block:(WTModuleMessagerCallback)block;

@end
