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

//Retrieving data
//+ (NSDictionary *)retrieveSourceDict;
+ (NSArray *)fetchCategoriesList;
+ (NSMutableArray *) getSelectedTopics;
+ (NSArray *) getSelectedTopicsQueryFormat;
+ (NSDictionary *)fetchGeneralSourceDictionary;
+ (NSMutableArray *)getSavedSources;
+ (NSDictionary *)getSavedSourcesDictionary;

//Saving data
+ (void)saveDefaultSources;
+ (void)saveDefaultTopics;

//General functioning
+ (NSString *) topicToQuery:(NSString *)topic;
+ (NSMutableArray *) parseTrendingTopics:(NSData * _Nullable) data response:(NSURLResponse * _Nullable)response error:(NSError * _Nullable) error;

@end

NS_ASSUME_NONNULL_END
