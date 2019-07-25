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

@end
