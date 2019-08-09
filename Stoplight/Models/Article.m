//
//  Article.m
//  Stoplight
//

//  Created by emily13hsiao on 7/16/19.

//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "Article.h"

@implementation Article

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    self.title = dictionary[@"name"];
    
    self.link = [NSURL URLWithString:dictionary[@"url"]];
    
    self.imageLink = [NSURL URLWithString:dictionary[@"image"][@"contentUrl"]];
    
    // No image is found, thumbnail is used
    if (self.imageLink == nil){
        self.imageLink = [NSURL URLWithString:dictionary[@"provider"][0][@"image"][@"thumbnail"][@"contentUrl"]];
    }
    
    // Set image, depending on the response that the API gives you 
    
    self.category = dictionary[@"category"];
    self.provider = [dictionary valueForKeyPath:@"provider.name"][0];
    
    return self;
}


+ (NSMutableArray *)articlesWithArray:(NSArray *)dictionaries {
    NSMutableArray *articles = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Article *article = [[Article alloc] initWithDictionary:dictionary];
        [articles addObject:article];
    }
    return articles;
}



@end
