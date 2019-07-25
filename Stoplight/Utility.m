//
//  Utility.m
//  Stoplight
//
//  Created by arleneigwe on 7/22/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "Utility.h"
#import "Models/Category.h"
#import "FeedViewController.h"

@implementation Utility

/**
 @property (strong, nonatomic) NSArray *allSourcesList;
 @property (strong, nonatomic) NSDictionary *siteDictionary;
**/

//Utility categoriesList = [NSMutableArray arrayWithObjects:@"politics", @"business", @"us", @"world", nil];
+ (instancetype)shared {
    static Utility *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        sharedManager.allSourcesList = [[NSArray alloc] initWithObjects:@"cnn", @"cnbc", @"economist", @"bloomberg", @"fox", @"washingtonexaminer", @"wsj", @"nbc", @"reuters", @"apnews", @"time", @"npr", nil];
        sharedManager.allLeftSources = [[NSArray alloc] initWithObjects:@"cnn", @"cnbc", @"nbc", @"time", nil];
        sharedManager.allCenterSources = [[NSArray alloc] initWithObjects:@"npr", @"reuters", @"bloomberg", @"apnews", @"economist", nil];
        sharedManager.allRightSources = [[NSArray alloc] initWithObjects:@"fox", @"wsj", @"washingtonexaminer", nil];
        
        //Not sure if the placement of this is correct
//        NSLog(@"%@", [[NSNumber alloc] initWithInt:(CategoryState)politics]);
//        sharedManager.categoriesList = @[[[NSNumber alloc] initWithInt:(CategoryState)politics], @(business), @(us), @(world)];
        sharedManager.categoriesList = [[NSArray alloc] initWithObjects:@"politics", @"business", @"us", @"world", nil];
    });
    return sharedManager;
}

/**
Returns array of arrays.
Outer array is by category.
Inner array is of site domains.
**/

// Try and make this more efficient if time permits


+ (NSMutableArray *) decideSourcesList {
    NSMutableArray *sourcesList = [NSMutableArray new];
    Utility *manager = [Utility shared];
    
    unsigned long int sizeOfCategoryArray = [manager.categoriesList count];
    NSLog(@"%lu", sizeOfCategoryArray);
    NSLog(@"%@", manager.categoriesList[0]);
    
    //Nested for loop, first by category then by source.
    for (int i = 0; i < manager.categoriesList.count; i++) {
        NSMutableArray *innerSourcesList = [NSMutableArray new];
        
        NSLog(@"%@", manager.categoriesList[i]);
        
        //Left
    
        [innerSourcesList addObject:[Utility getSiteURL:manager.allLeftSources[0] category:manager.categoriesList[i]]];
        [innerSourcesList addObject:[Utility getSiteURL:manager.allLeftSources[1] category:manager.categoriesList[i]]];

        //Center
        [innerSourcesList addObject:[Utility getSiteURL:manager.allCenterSources[0] category:manager.categoriesList[i]]];
        [innerSourcesList addObject:[Utility getSiteURL:manager.allCenterSources[1] category:manager.categoriesList[i]]];

        //Right
        [innerSourcesList addObject:[Utility getSiteURL:manager.allRightSources[0] category:manager.categoriesList[i]]];
        [innerSourcesList addObject:[Utility getSiteURL:manager.allRightSources[1] category:manager.categoriesList[i]]];
        
        [sourcesList addObject:innerSourcesList];
    }
    return sourcesList;
}

+ (NSString *)getSiteURL:(NSString *)site category:(NSString *)category {
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

+ (NSString *)getNPRSite:(NSString *)category {
    if ([category isEqualToString:@"business"]) {
        return @"npr.org/sections/business";
    } else if ([category isEqualToString:@"politics"]) {
        return @"npr.org/sections/politics";
    } else if ([category isEqualToString:@"us"]) {
        return @"npr.org/sections/national";
    } else if ([category isEqualToString:@"world"]) {
        return @"npr.org/sections/world";
    } else {
        return nil;
    }
//    switch (category) {
//        case business:
//            return @"npr.org/sections/business";
//        case politics:
//            return @"npr.org/sections/politics";
//        case us:
//            return @"npr.org/sections/national";
//        case world:
//            return @"npr.org/sections/world";
//    }
}

+ (NSString *)getTimeSite:(NSString *)category {
    if ([category isEqualToString:@"business"]) {
        return @"time.com/section/business";
    } else if ([category isEqualToString:@"politics"]) {
        return @"time.com/section/politics";
    } else if ([category isEqualToString:@"us"]) {
        return @"time.com/section/us";
    } else if ([category isEqualToString:@"world"]) {
        return @"time.com/section/world";
    } else {
        return nil;
    }
//    switch (category) {
//        case business:
//            return @"time.com/section/business";
//        case politics:
//            return @"time.com/section/politics";
//        case us:
//            return @"time.com/section/us";
//        case world:
//            return @"time.com/section/world";
//    }
}

+ (NSString *)getAPSite:(NSString *)category {
//    switch (category) {
//        case business:
//            return @"apnews.com/apf-business";
//        case politics:
//            return @"apnews.com/apf-politics";
//        case us:
//            return @"apnews.com/apf-usnews";
//        case world:
//            return @"apnews.com/apf-intlnews";
//    }
    if ([category isEqualToString:@"business"]) {
        return @"apnews.com/apf-business";
    } else if ([category isEqualToString:@"politics"]) {
        return @"apnews.com/apf-politics";
    } else if ([category isEqualToString:@"us"]) {
        return @"apnews.com/apf-usnews";
    } else if ([category isEqualToString:@"world"]) {
        return @"apnews.com/apf-intlnews";
    } else {
        return nil;
    }
}

+ (NSString *)getReutersSite:(NSString *)category {
    if ([category isEqualToString:@"business"]) {
        return @"reuters.com/finance";
    } else if ([category isEqualToString:@"politics"]) {
        return @"reuters.com/politics";
    } else if ([category isEqualToString:@"us"]) {
        return @"reuters.com";
    } else if ([category isEqualToString:@"world"]) {
        return @"reuters.com/news/world";
    } else {
        return nil;
    }
//    switch (category) {
//        case business:
//            return @"reuters.com/finance";
//        case politics:
//            return @"reuters.com/politics";
//        case us:
//            return @"reuters.com";
//        case world:
//            return @"reuters.com/news/world";
//    }
}

+ (NSString *)getNBCSite:(NSString *)category {
    if ([category isEqualToString:@"business"]) {
        return @"nbcnews.com/business";
    } else if ([category isEqualToString:@"politics"]) {
        return @"nbcnews.com/politics";
    } else if ([category isEqualToString:@"us"]) {
        return @"nbcnews.com/us-news";
    } else if ([category isEqualToString:@"world"]) {
        return @"nbcnews.com/world";
    } else {
        return nil;
    }
//    switch (category) {
//        case business:
//            return @"nbcnews.com/business";
//        case politics:
//            return @"nbcnews.com/politics";
//        case us:
//            return @"nbcnews.com/us-news";
//        case world:
//            return @"nbcnews.com/world";
//    }
}

+ (NSString *)getWSJSite:(NSString *)category {
    if ([category isEqualToString:@"business"]) {
        return @"wsj.com/news/business";
    } else if ([category isEqualToString:@"politics"]) {
        return @"wsj.com/news/politics";
    } else if ([category isEqualToString:@"us"]) {
        return @"wsj.com/news/us";
    } else if ([category isEqualToString:@"world"]) {
        return @"wsj.com/news/world";
    } else {
        return nil;
    }
//    switch (category) {
//        case business:
//            return @"wsj.com/news/business";
//        case politics:
//            return @"wsj.com/news/politics";
//        case us:
//            return @"wsj.com/news/us";
//        case world:
//            return @"wsj.com/news/world";
//    }
}

+ (NSString *)getWashingtonExaminerSite:(NSString *)category {
//    switch (category) {
//        case business:
//            return @"washingtonexaminer.com/business";
//        case politics:
//            return @"washingtonexaminer.com/politics";
//        case us:
//            return @"washingtonexaminer.com";
//        case world:
//            return nil;
//    }
    if ([category isEqualToString:@"business"]) {
        return @"washingtonexaminer.com/business";
    } else if ([category isEqualToString:@"politics"]) {
        return @"washingtonexaminer.com/politics";
    } else if ([category isEqualToString:@"us"]) {
        return @"washingtonexaminer.com";
    } else if ([category isEqualToString:@"world"]) {
        return nil;
    } else {
        return nil;
    }
}

+ (NSString *)getFoxSite:(NSString *)category {
//    switch (category) {
//        case business:
//            return @"foxbusiness.com";
//        case politics:
//            return @"foxnews.com/politics";
//        case us:
//            return @"foxnews.com/us";
//        case world:
//            return @"foxnews.com/world";
//    }
    if ([category isEqualToString:@"business"]) {
        return @"foxbusiness.com";
    } else if ([category isEqualToString:@"politics"]) {
        return @"foxnews.com/politics";
    } else if ([category isEqualToString:@"us"]) {
        return @"foxnews.com/us";
    } else if ([category isEqualToString:@"world"]) {
        return @"foxnews.com/world";
    } else {
        return nil;
    }
}

+ (NSString *)getCNNSite:(NSString *)category {
    if ([category isEqualToString:@"business"]) {
        return @"cnn.com/business";
    } else if ([category isEqualToString:@"politics"]) {
        return @"cnn.com/politics";
    } else if ([category isEqualToString:@"us"]) {
        return @"cnn.com/us";
    } else if ([category isEqualToString:@"world"]) {
        return @"cnn.com/world";
    } else {
        return nil;
    }
//    switch (category) {
//        case business:
//            return @"cnn.com/business";
//        case politics:
//            return @"cnn.com/politics";
//        case us:
//            return @"cnn.com/us";
//        case world:
//            return @"cnn.com/world";
//    }
}

+ (NSString *)getCNBCSite:(NSString *)category {
//    switch (category) {
//        case business:
//            return @"cnbc.com/business";
//        case politics:
//            return @"cnbc.com/politics";
//        case us:
//            return @"cnbc.com/?region=usas";
//        case world:
//            return @"cnbc.com/world";
//    }
    if ([category isEqualToString:@"business"]) {
        return @"cnbc.com/business";
    } else if ([category isEqualToString:@"politics"]) {
        return @"cnbc.com/politics";
    } else if ([category isEqualToString:@"us"]) {
        return @"cnbc.com/?region=usas";
    } else if ([category isEqualToString:@"world"]) {
        return @"cnbc.com/world";
    } else {
        return nil;
    }
}

+ (NSString *)getEconomistSite:(NSString *)category {
//    switch (category) {
//        case business:
//            return @"economist.com/business";
//        case politics: //they don't have a politics section??
//            return nil;
//        case us:
//            return @"economist.com/united-states";
//        case world:
//            return @"economist.com/international/";
//    }
    if ([category isEqualToString:@"business"]) {
        return @"economist.com/business";
    } else if ([category isEqualToString:@"politics"]) {
        return nil;
    } else if ([category isEqualToString:@"us"]) {
        return @"economist.com/united-states";
    } else if ([category isEqualToString:@"world"]) {
        return @"economist.com/international/";
    } else {
        return nil;
    }
}

+ (NSString *)getBloombergSite:(NSString *)category{
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
