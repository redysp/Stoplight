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

+ (instancetype)shared {
    static Utility *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        
        NSDictionary *politicsDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@[@"vox.com", @"nbcnews.com"], @"left",
                                            @[@"reuters.com", @"apnews.com"], @"center",
                                            @[@"foxnews.com", @"nypost.com"], @"right", nil];
        
        NSDictionary *businessDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@[@"cnbc.com", @"economist.com"], @"left",
                                            @[@"wsj.com", @"bloomberg.com"], @"center",
                                            @[@"foxbusiness.com", @"washingtonexaminer.com/business"], @"right", nil];
        
        NSDictionary *usDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@[@"cnn.com", @"time.com"], @"left",
                                      @[@"npr.org", @"usatoday.com"], @"center",
                                      @[@"foxnews.com", @"spectator.org"], @"right", nil];
        
        NSDictionary *worldDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@[@"cnn.com/world", @"theguardian.com"], @"left",
                                         @[@"reuters.com", @"bbc.com"], @"center",
                                         @[@"foxnews.com/world", @"dailymail.co.uk"], @"right", nil];
        
        
        
        sharedManager.siteDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:politicsDictionary, @"politics", businessDictionary, @"business", usDictionary, @"us", worldDictionary, @"world", nil];
    });
    return sharedManager;
}

+ (NSDictionary *)retrieveSourceDict{
    return [Utility shared].siteDictionary;
}

+ (NSArray *)fetchCategoriesList {
    //This is what it should be eventually but just keeping it like this for functionality rn.
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSArray *categoriesList = [defaults objectForKey:@"categoriesList"];
    //    return categoriesList
    return [NSArray arrayWithObjects:@"politics", @"business", @"us", @"world", nil];;
}

+ (NSArray *)fetchTopicsList {
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSArray *topicsList = [defaults objectForKey:@"topicsList"];
    //    return topicsList;
    return [NSArray arrayWithObjects:@"Global+Warming", @"sudan", nil];
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
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSDictionary *sourcesDictionary = [defaults objectForKey:@"sourcesForTopics"];
    //    return sourcesDictionary;
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
    
//    NSMutableDictionary *politicsDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                         [@{@"vox.com":@YES, @"nbcnews.com":@YES}  mutableCopy], @"left",
//                                         [@{@"reuters.com":@YES, @"apnews.com":@YES}  mutableCopy], @"center",
//                                         [@{@"foxnews.com":@YES, @"nypost.com":@YES}  mutableCopy], @"right",
//                                         nil];
//    NSMutableDictionary *businessDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                         [@{@"cnbc.com":@YES, @"economist.com":@YES}  mutableCopy], @"left",
//                                         [@{@"wsj.com":@YES, @"bloomberg.com":@YES}  mutableCopy], @"center",
//                                         [@{@"foxbusiness.com":@YES, @"washingtonexaminer.com/business":@YES} mutableCopy], @"right",
//                                         nil];
//    NSMutableDictionary *usDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                         [@{@"cnn.com":@YES, @"time.com":@YES}  mutableCopy], @"left",
//                                         [@{@"npr.org":@YES, @"usatoday.com":@YES}  mutableCopy], @"center",
//                                         [@{@"foxnews.com":@YES, @"spectator.org":@YES} mutableCopy], @"right",
//                                         nil];
//    NSMutableDictionary *worldDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                   [@{@"cnn.com/world":@YES, @"theguardian.com":@YES}  mutableCopy], @"left",
//                                   [@{@"reuters.com":@YES, @"bbc.com":@YES}  mutableCopy], @"center",
//                                   [@{@"foxnews.com/world":@YES, @"dailymail.co.uk":@YES} mutableCopy], @"right",
//                                   nil];
    NSMutableDictionary *politicsDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                         [[NSMutableDictionary alloc] initWithDictionary:@{@"vox.com":@YES, @"nbcnews.com":@YES}], @"left",
                                         [[NSMutableDictionary alloc] initWithDictionary:@{@"reuters.com":@YES, @"apnews.com":@YES}], @"center",
                                         [[NSMutableDictionary alloc] initWithDictionary:@{@"foxnews.com":@YES, @"nypost.com":@YES}], @"right",
                                         nil];
    NSMutableDictionary *businessDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                         [[NSMutableDictionary alloc] initWithDictionary:@{@"cnbc.com":@YES, @"economist.com":@YES}], @"left",
                                         [[NSMutableDictionary alloc] initWithDictionary:@{@"wsj.com":@YES, @"bloomberg.com":@YES}], @"center",
                                         [[NSMutableDictionary alloc] initWithDictionary:@{@"foxbusiness.com":@YES, @"washingtonexaminer.com/business":@YES}], @"right",
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
//    NSMutableArray *arr = [@[
//                     //Politics
//                     [@{@"left":[@{@"vox.com":@YES, @"nbcnews.com":@YES}  mutableCopy],@"center":[@{@"reuters.com":@YES, @"apnews.com":@YES}  mutableCopy],@"right":[@{@"foxnews.com":@YES, @"nypost.com":@YES}  mutableCopy]} mutableCopy],
//                     //Business
//                     [@{@"left":[@{@"cnbc.com":@YES, @"economist.com":@YES}  mutableCopy],@"center":[@{@"wsj.com":@YES, @"bloomberg.com":@YES}  mutableCopy],@"right":[@{@"foxbusiness.com":@YES, @"washingtonexaminer.com/business":@YES} mutableCopy]} mutableCopy],
//                     //US
//                     [@{@"left":[@{@"cnn.com":@YES, @"time.com":@YES}  mutableCopy],@"center":[@{@"npr.org":@YES, @"usatoday.com":@YES}  mutableCopy],@"right":[@{@"foxnews.com":@YES, @"spectator.org":@YES} mutableCopy]} mutableCopy],
//                     //World
//                     [@{@"left":[@{@"cnn.com/world":@YES, @"theguardian.com":@YES}  mutableCopy],@"center":[@{@"reuters.com":@YES, @"bbc.com":@YES}  mutableCopy],@"right":[@{@"foxnews.com/world":@YES, @"dailymail.co.uk":@YES} mutableCopy]} mutableCopy]] mutableCopy];
    [defaults setObject:arr forKey:@"savedSources"];
    [defaults synchronize];
}

/**
Returns that weird array of dictionaries you want for categories, for the ADJUST CATEGORIES SOURCES page.
**/
+ (NSMutableArray *)getSavedSources {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *savedSources = [defaults objectForKey:@"savedSources"];
        return savedSources;
}

/**
Returns dictionary format sources for FEED VIEW CONTROLLER.
**/
+ (NSDictionary *)getSavedSourcesDictionary {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *savedSourcesDictionary = [defaults objectForKey:@"savedSourcesDictionary"];
    return savedSourcesDictionary;
}


@end
