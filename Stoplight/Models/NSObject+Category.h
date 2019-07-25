//
//  NSObject+Category.h
//  Stoplight
//
//  Created by emily13hsiao on 7/25/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Category)

typedef enum {
    politics,
    business,
    us,
    world
} CategoryState;

@end

NS_ASSUME_NONNULL_END
