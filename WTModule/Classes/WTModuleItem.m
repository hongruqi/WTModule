//
//  WTModuleItem.m
//  Pods
//
//  Created by walter on 05/08/2017.
//
//

#import "WTModuleItem.h"

@implementation WTModuleItem

- (instancetype)initWithModule:(id)module priority:(NSInteger)priority sequence:(NSInteger)sequence
{
    if (self = [super init]) {
        self.module = module;
        self.priority = priority;
        self.sequence = sequence;
    }
    
    return self;
}
@end
