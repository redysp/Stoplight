//
//  Category.h
//  Stoplight
//
//  Created by emily13hsiao on 7/24/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Category : NSObject

typedef enum CategoryStateTypes {
    business,
    politics,
    us,
    world
} CategoryState;

@end

NS_ASSUME_NONNULL_END
