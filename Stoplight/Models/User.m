//
//  User.m
//  Stoplight
//
//  Created by arleneigwe on 7/16/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "User.h"

@implementation User
- (void) setStuff{
    // code below is temporary!!!!
    self.preferred_sources = [NSMutableArray arrayWithObjects:@"CNN", @"Economist", @"Fox", @"WSJ", nil];
    self.checkedSources = [NSMutableArray arrayWithObjects:@(1), @(0), @(1), @(0), @(1), @(0), @(1), @(0), @(0), @(0), @(0), @(0), nil];
    if(self.preferred_topics == nil){
    self.preferred_topics = [NSMutableArray arrayWithObjects:@"Politics", @"White House", @"Global Warming", @"Celebrities", @"Sudan", @"Texas", nil];
    }
}

@end
