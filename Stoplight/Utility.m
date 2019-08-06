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


@end
