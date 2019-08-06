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

- (NSString*)getArticleAffiliation{
    self.affiliation = @"left";
    return self.affiliation; 
}

@end
