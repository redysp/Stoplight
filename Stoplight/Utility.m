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

+ (NSArray *)fetchCategoriesList {
    return [NSArray arrayWithObjects:@"politics", @"business", @"us", @"world", nil];;
}

/**
Returns dictionary with this structure
 {
 "left": [cnn.com, vox.com]
 "center": [npr.org, cnbc.com"]
 "right": [foxnews.com, nypost.com"]
 }
**/
+ (NSDictionary *)fetchGeneralSourceDictionary {
    NSArray *leftArray = [NSArray arrayWithObjects:@"cnn.com", @"theguardian.com", nil];
    NSArray *centerArray = [NSArray arrayWithObjects:@"npr.org", @"reuters.com", nil];
    NSArray *rightArray = [NSArray arrayWithObjects:@"foxnews.com", @"wsj.com", nil];
    NSDictionary *sourcesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:leftArray, @"left", centerArray, @"center", rightArray, @"right", nil];
    return sourcesDictionary;
}

/**
Takes in human-readable topic (ex "Global Warming") and creates
query format (ex "Global+Warming)
**/
+ (NSString *) topicToQuery:(NSString *)topic {
    return [topic stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}

+ (void)saveDefaultSources {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSMutableDictionary *politicsDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                         [[NSMutableDictionary alloc] initWithDictionary:@{@"vox.com":@YES, @"nbcnews.com":@YES, @"huffpost.com":@NO, @"slate.com":@NO, @"msnbc.com":@NO}], @"left",
                                         [[NSMutableDictionary alloc] initWithDictionary:@{@"reuters.com":@YES, @"apnews.com":@YES, @"thehill.com":@NO, @"usatoday.com":@NO, @"npr.org":@NO}], @"center",
                                         [[NSMutableDictionary alloc] initWithDictionary:@{@"foxnews.com":@YES, @"nypost.com":@YES, @"washingtontimes.com":@NO, @"thefederalist.com":@NO, @"dailywire.com":@NO}], @"right",
                                         nil];
    NSMutableDictionary *businessDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                         [[NSMutableDictionary alloc] initWithDictionary:@{@"cnbc.com":@YES, @"economist.com":@YES, @"cnn.com/business":@NO, }], @"left",
                                         [[NSMutableDictionary alloc] initWithDictionary:@{@"wsj.com":@YES, @"bloomberg.com":@YES, @"ft.com":@NO}], @"center",
                                         [[NSMutableDictionary alloc] initWithDictionary:@{@"foxbusiness.com":@YES, @"washingtonexaminer.com/business":@YES, @"marketwatch.com":@NO}], @"right",
                                         nil];
    NSMutableDictionary *usDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   [[NSMutableDictionary alloc] initWithDictionary:@{@"cnn.com":@YES, @"time.com":@YES}], @"left",
                                   [[NSMutableDictionary alloc] initWithDictionary:@{@"npr.org":@YES, @"usatoday.com":@YES}], @"center",
                                   [[NSMutableDictionary alloc] initWithDictionary:@{@"foxnews.com":@YES, @"spectator.org":@YES}], @"right",
                                   nil];
    NSMutableDictionary *worldDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                      [[NSMutableDictionary alloc] initWithDictionary:@{@"cnn.com/world":@YES, @"theguardian.com":@YES}], @"left",
                                      [[NSMutableDictionary alloc] initWithDictionary:@{@"reuters.com":@YES, @"bbc.com":@YES}], @"center",
                                      [[NSMutableDictionary alloc] initWithDictionary:@{@"foxnews.com/world":@YES, @"dailymail.co.uk":@YES}], @"right",
                                      nil];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:politicsDict, businessDict, usDict, worldDict, nil];
    
    [defaults setObject:arr forKey:@"savedSources"];
    [defaults synchronize];
    
    NSMutableDictionary *defaultSourcesDictionary = [[NSMutableDictionary alloc] init];
    
    NSArray *slantList = [NSArray arrayWithObjects:@"left", @"center", @"right", nil];
    NSArray *sectionNames = [NSArray arrayWithObjects:@"politics", @"business", @"us", @"world", nil];
    
    for (int i = 0; i < sectionNames.count; i++) {
        NSString *categoryName = sectionNames[i];
        NSMutableDictionary *categoryDictionary = [[NSMutableDictionary alloc] init];
        for (NSString *slant in slantList) {
            NSMutableArray *sourcesBySlant = [NSMutableArray new];
            for (NSString *source in arr[i][slant]) {
                if ([arr[i][slant][source] boolValue]) {
                    [sourcesBySlant addObject:source];
                }
            }
            [categoryDictionary setObject:sourcesBySlant forKey:slant];
        }
        [defaultSourcesDictionary setObject:categoryDictionary forKey:categoryName];
    }
    [defaults setObject:defaultSourcesDictionary forKey:@"savedSourcesDictionary"];
    [defaults synchronize];
}

/**
Returns that weird array of dictionaries you want for categories, for the ADJUST CATEGORIES SOURCES page.
**/
+ (NSMutableArray *)getSavedSources {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *savedSources = [defaults objectForKey:@"savedSources"];
    if (savedSources) {
        return savedSources;
    } else {
        [Utility saveDefaultSources];
        savedSources = [defaults objectForKey:@"savedSources"];
        return savedSources;
    }
}

/**
Returns dictionary format sources for FEED VIEW CONTROLLER.
**/
+ (NSDictionary *)getSavedSourcesDictionary {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *savedSourcesDictionary = [defaults objectForKey:@"savedSourcesDictionary"];
    
    if (savedSourcesDictionary) {
        return savedSourcesDictionary;
    } else {
        [Utility saveDefaultSources];
        savedSourcesDictionary = [defaults objectForKey:@"savedSources"];
        return savedSourcesDictionary;
    }
}

/**
Gives adjust topics page the array of topics.
**/
+ (NSMutableArray *) getSelectedTopics {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *savedSources = [defaults objectForKey:@"selectedTopics"];
    return [savedSources mutableCopy];
}

/**
 Gives feed view controller list of things to query.
 **/
+ (NSArray *) getSelectedTopicsQueryFormat {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *topicsList = [defaults objectForKey:@"selectedTopicsQueryFormat"];
    return topicsList;
}

+ (void) saveDefaultTopics {
    //Save in raw form.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSArray arrayWithObjects:@"Global Warming", @"Sudan", nil] forKey:@"selectedTopics"];
    [defaults synchronize];
    
    //Save in form feed view controller uses.
    [defaults setObject:[NSArray arrayWithObjects:@"global+warming", @"sudan", nil] forKey:@"selectedTopicsQueryFormat"];
    [defaults synchronize];
}

+ (NSMutableArray *) parseTrendingTopics:(NSData * _Nullable) data response:(NSURLResponse * _Nullable)response error:(NSError * _Nullable) error {
    NSMutableArray *array = [NSMutableArray new];
    
    if (error) {
        return array;
    }
    
    NSDictionary *rawJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSArray *arrayOfDictionaries = rawJSON[@"value"];
    
    for (NSDictionary *dict in arrayOfDictionaries) {
        [array addObject:dict[@"query"][@"text"]];
    }
    
    return array;
}
@end
