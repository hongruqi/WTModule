//
//  WTEventItem.h
//  WTModule
//
//  Created by hongru qi on 16/11/2017.
//

#import <Foundation/Foundation.h>
@class WTEventContext;

@interface WTEventItem : NSObject

@property (nonnull, nonatomic, copy, readonly) NSString *topic;

@property (nonnull, nonatomic, strong, readonly) WTEventContext *context;

- (nullable NSDictionary *)params;

- (void)setParam:(nonnull id)param forKey:(nonnull NSString *)key;

- (nonnull instancetype)initWithTopic:(nonnull NSString *)topic ;

@end
