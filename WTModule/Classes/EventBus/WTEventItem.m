//
//  WTEventItem.m
//  WTModule
//
//  Created by hongru qi on 16/11/2017.
//

#import "WTEventItem.h"
#import "WTEventContext.h"

@interface WTEventItem()

@property   (nonatomic, strong) NSDictionary *params;

@property   (nonatomic, strong) NSMutableDictionary *mParams;

@end

@implementation WTEventItem

- (NSDictionary *)params
{
    if (!_params) {
        _params = [NSDictionary dictionaryWithDictionary:_mParams];
    }
    return _params;
}

- (void)setParam:(id)param forKey:(NSString *)key
{
    if (!_mParams) {
        _mParams = [[NSMutableDictionary alloc] init];
    }
    if (param && key) {
        [_mParams setObject:param forKey:key];
    }
    _params = [NSDictionary dictionaryWithDictionary:_mParams];
}

- (instancetype)initWithTopic:(NSString *)topic
{
    self = [super init];
    if (self) {
        _topic = topic;
        _context = [[WTEventContext alloc] init];
        _context.event = self;
    }
    return self;
}
@end
