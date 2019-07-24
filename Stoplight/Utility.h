//
//  Utility.h
//  Stoplight
//
//  Created by arleneigwe on 7/22/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Models/Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface Utility : NSObject

@property (strong, nonatomic) NSArray *allSourcesList;
@property (strong, nonatomic) NSDictionary *siteDictionary;

+ (NSDictionary *)retrieveSourceDict;
+ (NSArray *)retrieveCategoriesList;
+ (NSString *)getSiteURL:(NSString *)site category:(CategoryState)category;

@end

NS_ASSUME_NONNULL_END
