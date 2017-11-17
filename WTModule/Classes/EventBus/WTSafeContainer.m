//
//  WTSafeContainer.m
//  WTModule
//
//  Created by hongru qi on 16/11/2017.
//

#import "WTSafeContainer.h"

@implementation WTSafeContainer

@end

@implementation NSDictionary (WTSafeContainer)

- (id)wt_objectForKey:(id)key
{
    if (key == nil) {
        return nil;
    }
    id value = [self objectForKey:key];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (id)wt_objectForKey:(id)key class:(__unsafe_unretained Class)aClass
{
    id value = [self wt_objectForKey:key];
    if (![value isKindOfClass:aClass]) {
        return nil;
    }
    return value;
}

- (id)wt_objectForKey:(id)key class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue
{
    id value = [self wt_objectForKey:key];
    if (![value isKindOfClass:aClass]) {
        return defaultValue;
    }
    return value;
}

- (NSDictionary *)wt_dictionaryForKey:(id)key
{
    id value = [self wt_objectForKey:key];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSString *)wt_stringForKey:(id)key
{
    id value = [self wt_objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    return nil;
}

- (BOOL)wt_boolForKey:(id)key
{
    return [self wt_boolForKey:key defaultValue:NO];
}

- (BOOL)wt_boolForKey:(id)key defaultValue:(BOOL)defaultValue
{
    id value = [self wt_objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    else {
        return defaultValue;
    }
}

- (CGFloat)wt_floatForKey:(id)key
{
    return [self wt_floatForKey:key defaultValue:0.f];
}

- (CGFloat)wt_floatForKey:(id)key defaultValue:(BOOL)defaultValue
{
    id value = [self wt_objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    else {
        return defaultValue;
    }
    
}

- (NSInteger)wt_integerForKey:(id)key
{
    return [self wt_integerForKey:key defaultValue:0];
}

- (NSInteger)wt_integerForKey:(id)key defaultValue:(BOOL)defaultValue
{
    id value = [self wt_objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value integerValue];
    }
    else {
        return defaultValue;
    }
}

- (NSString *)tgrm_stringForKey:(id)key
{
    id value = [self wt_objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)tgrm_dictionaryForKey:(id)key
{
    id value = [self wt_objectForKey:key];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSArray *)wt_arrayForKey:(id)key
{
    id value = [self wt_objectForKey:key];
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

@end

@implementation NSArray (WTSafeContainer)

- (id)wt_objectAtIndex:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (id)wt_objectAtIndex:(NSUInteger)index class:(__unsafe_unretained Class)aClass
{
    id value = [self wt_objectAtIndex:index];
    if (![value isKindOfClass:aClass]) {
        return nil;
    }
    return value;
}

- (id)wt_objectAtIndex:(NSUInteger)index class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue
{
    id value = [self wt_objectAtIndex:index];
    if (![value isKindOfClass:aClass]) {
        return defaultValue;
    }
    return value;
}

- (void)wt_addObject:(id)object
{
    if ([self isKindOfClass:[NSMutableArray class]] && nil != object) {
        [(NSMutableArray *)self addObject:object];
    }
}

- (CGFloat)wt_floatAtIndex:(NSUInteger)index
{
    id value = [self wt_objectAtIndex:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0.f;
}

- (NSDictionary *)wt_dictionaryAtIndex:(NSUInteger)index
{
    id value = [self wt_objectAtIndex:index];
    if ([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSString *)wt_stringAtIndex:(NSUInteger)index
{
    id value = [self wt_objectAtIndex:index];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    return nil;
}

@end
