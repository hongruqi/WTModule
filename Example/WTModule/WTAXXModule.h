//
//  WTAXXModule.h
//  WTModule
//
//  Created by walter on 07/08/2017.
//  Copyright © 2017 lbrsilva-allin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTModule.h"

@interface WTAXXModule : NSObject<WTModuleLifecycleDelegate>

- (NSString *)liveShowStart:(NSDictionary *)params;
- (void)liveShowEnd:(NSDictionary *)params block:(WTModuleMessagerCallback) block;
- (void)login:(NSDictionary *)params block:(WTModuleMessagerCallback) block;
- (void)pushLiveShowController:(NSDictionary *)params;

@end
