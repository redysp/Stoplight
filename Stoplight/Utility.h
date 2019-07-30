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
@property (strong, nonatomic) NSArray *allLeftSources;
@property (strong, nonatomic) NSArray *allCenterSources;
@property (strong, nonatomic) NSArray *allRightSources;
@property (strong, nonatomic) NSDictionary *siteDictionary;
@property (strong, nonatomic) NSArray *categoriesList;

+ (instancetype)shared;
+ (NSDictionary *)retrieveSourceDict;
+ (NSArray *)fetchCategoriesList;
+ (NSArray *)fetchTopicsList;
+ (NSDictionary *)fetchSourceDictionaryForTopics;

//+ (NSString *)getSiteURL:(NSString *)site category:(NSString *)category;
//+ (NSMutableArray *) decideSourcesList;
//- (NSArray *)getAllPossibleSources;

@end

NS_ASSUME_NONNULL_END
