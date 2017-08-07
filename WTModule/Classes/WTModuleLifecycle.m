//
//  WTModuleLifecycle.m
//  Pods
//
//  Created by walter on 05/08/2017.
//
//

#import "WTModuleLifecycle.h"
#import "WTModuleItem.h"
#import "WTModuleLifecycleDelegate.h"

@interface WTModuleLifecycle(){
    CFBinaryHeapRef _modules;
}

@property (nonatomic, assign) NSInteger nextSequence;
@property (nonatomic, strong) NSMutableDictionary *moduleCache;

@end

static const void *WTModuleItemPriorityRetain(CFAllocatorRef allocator, const void *ptr) {
    return CFRetain(ptr);
}

static void WTModuleItemPriorityRelease(CFAllocatorRef allocator, const void *ptr) {
    CFRelease(ptr);
}

static CFComparisonResult WTModuleItemPriorityCompare(const void *ptr1, const void *ptr2, void *info)
{
    WTModuleItem *item1 = (__bridge WTModuleItem *)ptr1;
    WTModuleItem *item2 = (__bridge WTModuleItem *)ptr2;
    
    if (item1.priority < item2.priority) {  // greator first
        return kCFCompareLessThan;
    }
    
    if (item1.priority > item2.priority) {
        return kCFCompareGreaterThan;
    }
    
    if (item1.sequence > item2.sequence) {  // lesser first
        return kCFCompareLessThan;
    }
    
    if (item1.sequence < item2.sequence) {
        return kCFCompareGreaterThan;
    }
    
    return kCFCompareEqualTo;
}

@implementation WTModuleLifecycle

+ (instancetype)instance
{
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        CFBinaryHeapCallBacks callbacks = (CFBinaryHeapCallBacks) {
            .version = 0,
            .retain = &WTModuleItemPriorityRetain,
            .release = &WTModuleItemPriorityRelease,
            .copyDescription = &CFCopyDescription,
            .compare = &WTModuleItemPriorityCompare
        };
        
        _modules = CFBinaryHeapCreate(kCFAllocatorDefault, 0, &callbacks, NULL);
        _moduleCache = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)dealloc
{
    if (_modules) {
        CFRelease(_modules);
    }
}

+ (void)registerModuleClass:(Class <WTModuleLifecycleDelegate>)moduleClass
                     config:(NSDictionary *)config
                   priority:(NSInteger)priority
{
    id <WTModuleLifecycleDelegate> module = [[(Class)moduleClass alloc] initWithConfiguration:config];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [[self instance] registerModule:module priority:priority];
#pragma clang diagnostic pop
}

- (void)enumerateModulesUsingBlock:(__attribute__((noescape)) void (^)(id module, BOOL *stop))block
{
    CFIndex count = CFBinaryHeapGetCount(_modules);
    const void **list = calloc(count, sizeof(const void *));
    CFBinaryHeapGetValues(_modules, list);
    
    CFArrayRef objects = CFArrayCreate(kCFAllocatorDefault, list, count, &kCFTypeArrayCallBacks);
    
    NSArray *items = (__bridge_transfer NSArray *)objects;
    
    [items enumerateObjectsWithOptions:NSEnumerationReverse
                            usingBlock:^(WTModuleItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                block(obj.module, stop);
                            }];
}

- (void)registerModule:(id)module priority:(NSInteger)priority
{
    WTModuleItem *item = [[WTModuleItem alloc] initWithModule:module
                                                     priority:priority
                                                     sequence:self.nextSequence];
    
    CFBinaryHeapAddValue(_modules, (__bridge const void *)(item));
    [self.moduleCache setValue:module forKey:NSStringFromClass([module class])];
    self.nextSequence += 1;
}

- (id)moduleInstanceByName:(NSString *)moduleName
{
    return self.moduleCache[moduleName];
}

@end
