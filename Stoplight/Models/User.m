//
//  User.m
//  Stoplight
//
//  Created by arleneigwe on 7/16/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "User.h"

@implementation User

+ (instancetype)shared {
    static User *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)setStuff{
    // code below is temporary!!!!
    self.preferred_sources = [NSMutableArray arrayWithObjects:@"CNN", @"Economist", @"Fox", @"WSJ", nil];
    self.checkedSources = [NSMutableArray arrayWithObjects:@(1), @(0), @(1), @(0), @(1), @(0), @(1), @(0), @(0), @(0), @(0), @(0), nil];
    self.affiliation = @"right";
}

- (NSString*)getArticleAffiliation{
    return self.affiliation; 
}

@end
