//
//  Utility.m
//  Stoplight
//
//  Created by arleneigwe on 7/22/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "Utility.h"

@implementation Utility
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

+ (instancetype)shared{
    = [[NSArray alloc] initWithObjects:@"cnn", @"cnbc", @"economist", @"bloomberg.com", @"foxbusiness.com", @"washingtonexaminer.com", @"wjs.com", @"vox.com", @"nbcnewscom", @"reuters.com", @"apnews.com", @"nypost.com", @"time.com", @"npr.org", nil];
}

@end
