//
//  WTModuleItem.h
//  Pods
//
//  Created by walter on 05/08/2017.
//
//

#import <Foundation/Foundation.h>

@interface WTModuleItem : NSObject

@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, assign) NSInteger sequence;
@property (nonatomic, strong) id module;

- (instancetype)initWithModule:(id)module
                      priority:(NSInteger)priority
                      sequence:(NSInteger)sequence;

@end
