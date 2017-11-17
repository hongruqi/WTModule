//
//  WTSafeContainer.h
//  WTModule
//
//  Created by hongru qi on 16/11/2017.
//

#import <Foundation/Foundation.h>

@interface WTSafeContainer : NSObject

@end

@interface NSDictionary (WTSafeContainer)

- (id)wt_objectForKey:(id)key;

- (id)wt_objectForKey:(id)key class:(__unsafe_unretained Class)aClass;

- (id)wt_objectForKey:(id)key class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue;

- (BOOL)wt_boolForKey:(id)key;

- (BOOL)wt_boolForKey:(id)key defaultValue:(BOOL)defaultValue;

- (CGFloat)wt_floatForKey:(id)key;

- (CGFloat)wt_floatForKey:(id)key defaultValue:(BOOL)defaultValue;

- (NSInteger)wt_integerForKey:(id)key;

- (NSInteger)wt_integerForKey:(id)key defaultValue:(BOOL)defaultValue;

- (NSString *)wt_stringForKey:(id)key;

- (NSDictionary *)wt_dictionaryForKey:(id)key;

- (NSArray *)wt_arrayForKey:(id)key;
@end

@interface NSArray (WTSafeContainer)

- (id)wt_objectAtIndex:(NSUInteger)index;

- (id)wt_objectAtIndex:(NSUInteger)index class:(__unsafe_unretained Class)aClass;

- (id)wt_objectAtIndex:(NSUInteger)index class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue;

- (void)wt_addObject:(id)object;

- (CGFloat)wt_floatAtIndex:(NSUInteger)index;

- (NSDictionary *)wt_dictionaryAtIndex:(NSUInteger)index;

- (NSString *)wt_stringAtIndex:(NSUInteger)index;
@end
