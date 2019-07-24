//
//  Utility.m
//  Stoplight
//
//  Created by arleneigwe on 7/22/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "Utility.h"
#import "Models/Category.h"

@implementation Utility

/**
 @property (strong, nonatomic) NSArray *allSourcesList;
 @property (strong, nonatomic) NSDictionary *siteDictionary;
**/

+ (instancetype)shared {
    static Utility *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        sharedManager.allSourcesList = [[NSArray alloc] initWithObjects:@"cnn", @"cnbc", @"economist", @"bloomberg", @"fox", @"washingtonexaminer", @"wsj", @"nbc", @"reuters", @"apnews", @"time", @"npr", nil];
    });
    return sharedManager;
}

+ (NSString *)getSiteURL:(NSString *)site category:(CategoryState)category {
    if ([site isEqualToString:@"cnn"]) {
        return [Utility getCNNSite:category];
    } else if ([site isEqualToString:@"cnbc"]) {
        return [Utility getCNBCSite:category];
    } else if ([site isEqualToString:@"economist"]) {
        return [Utility getEconomistSite:category];
    } else if ([site isEqualToString:@"bloomberg"]) {
        return [Utility getBloombergSite:category];
    } else if ([site isEqualToString:@"fox"]) {
        return [Utility getFoxSite:category];
    } else if ([site isEqualToString:@"washingtonexaminer"]) {
        return [Utility getWashingtonExaminerSite:category];
    } else if ([site isEqualToString:@"wsj"]) {
        return [Utility getWSJSite:category];
    } else if ([site isEqualToString:@"nbc"]) {
        return [Utility getNBCSite:category];
    } else if ([site isEqualToString:@"reuters"]) {
        return [Utility getReutersSite:category];
    } else if ([site isEqualToString:@"apnews"]) {
        return [Utility getAPSite:category];
    } else if ([site isEqualToString:@"time"]) {
        return [Utility getTimeSite:category];
    } else if ([site isEqualToString:@"npr"]) {
        return [Utility getNPRSite:category];
    } else {
        NSLog(@"INVALID SITE.");
        return nil;
    }
}

+ (NSString *)getNPRSite:(CategoryState)category {
    switch (category) {
        case business:
            return @"npr.org/sections/business";
        case politics:
            return @"npr.org/sections/politics";
        case us:
            return @"npr.org/sections/national";
        case world:
            return @"npr.org/sections/world";
    }
}

+ (NSString *)getTimeSite:(CategoryState)category {
    switch (category) {
        case business:
            return @"time.com/section/business";
        case politics:
            return @"time.com/section/politics";
        case us:
            return @"time.com/section/us";
        case world:
            return @"time.com/section/world";
    }
}

+ (NSString *)getAPSite:(CategoryState)category {
    switch (category) {
        case business:
            return @"apnews.com/apf-business";
        case politics:
            return @"apnews.com/apf-politics";
        case us:
            return @"apnews.com/apf-usnews";
        case world:
            return @"apnews.com/apf-intlnews";
    }
}

+ (NSString *)getReutersSite:(CategoryState)category {
    switch (category) {
        case business:
            return @"reuters.com/finance";
        case politics:
            return @"reuters.com/politics";
        case us:
            return @"reuters.com";
        case world:
            return @"reuters.com/news/world";
    }
}

+ (NSString *)getNBCSite:(CategoryState)category {
    switch (category) {
        case business:
            return @"nbcnews.com/business";
        case politics:
            return @"nbcnews.com/politics";
        case us:
            return @"nbcnews.com/us-news";
        case world:
            return @"nbcnews.com/world";
    }
}

+ (NSString *)getWSJSite:(CategoryState)category {
    switch (category) {
        case business:
            return @"wsj.com/news/business";
        case politics:
            return @"wsj.com/news/politics";
        case us:
            return @"wsj.com/news/us";
        case world:
            return @"wsj.com/news/world";
    }
}

+ (NSString *)getWashingtonExaminerSite:(CategoryState)category {
    switch (category) {
        case business:
            return @"washingtonexaminer.com/business";
        case politics:
            return @"washingtonexaminer.com/politics";
        case us:
            return @"washingtonexaminer.com";
        case world:
            return nil;
    }
}

+ (NSString *)getFoxSite:(CategoryState)category {
    switch (category) {
        case business:
            return @"foxbusiness.com";
        case politics:
            return @"foxnews.com/politics";
        case us:
            return @"foxnews.com/us";
        case world:
            return @"foxnews.com/world";
    }
}

+ (NSString *)getCNNSite:(CategoryState)category {
    switch (category) {
        case business:
            return @"cnn.com/business";
        case politics:
            return @"cnn.com/politics";
        case us:
            return @"cnn.com/us";
        case world:
            return @"cnn.com/world";
    }
}

+ (NSString *)getCNBCSite:(CategoryState)category {
    switch (category) {
        case business:
            return @"cnbc.com/business";
        case politics:
            return @"cnbc.com/politics";
        case us:
            return @"cnbc.com/?region=usas";
        case world:
            return @"cnbc.com/world";
    }
}

+ (NSString *)getEconomistSite:(CategoryState)category {
    switch (category) {
        case business:
            return @"economist.com/business";
        case politics: //they don't have a politics section??
            return nil;
        case us:
            return @"economist.com/united-states";
        case world:
            return @"economist.com/international/";
    }
}

+ (NSString *)getBloombergSite:(CategoryState)category{
    return @"bloomberg.com";
}


+ (NSDictionary *)retrieveSourceDict{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults dictionaryForKey:@"sourcesDict"];
    return dict;
}

+ (NSArray *)retrieveCategoriesList{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *dict = [defaults arrayForKey:@"categoriesArray"];
    return dict;
}

- (NSArray *)getAllPossibleSources{
    return self.allSourcesList;
}

@end
