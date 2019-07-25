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

- (NSArray *)getAllPossibleSources;
+ (instancetype)shared;
+ (NSDictionary *)retrieveSourceDict;
+ (NSArray *)retrieveCategoriesList;
+ (NSString *)getSiteURL:(NSString *)site category:(NSString *)category;
+ (NSMutableArray *) decideSourcesList;
//TODO: RETRIEVE USER SETTINGS FOR EACH POLITICAL SLANT SOURCES.


@end

NS_ASSUME_NONNULL_END
