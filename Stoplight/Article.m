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
    
    /**
     @property (nonatomic, strong) NSString *title;
     @property (nonatomic, strong) NSString *author;
     @property (nonatomic, strong) NSURL *link;
     @property (nonatomic, strong) NSURL *imageLink;
     @property (nonatomic, strong) NSString *provider;
     @property (nonatomic, strong) NSString *summary;
     @property (nonatomic, strong) NSString *text;
     @property (nonatomic, strong) NSDate *publishedAt;
     **/
    
    self.title = dictionary[@"title"];
    self.author = dictionary[@"author"];
    self.link = [NSURL URLWithString:dictionary[@"url"]];
    //self.imageLink = [NSURL URLWithString:dictionary[@"urlToImage"]];
    self.provider = dictionary[@"source"][@"name"];
    self.summary = dictionary[@"description"];
    self.text = dictionary[@"content"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    self.publishedAt = [dateFormatter dateFromString:dictionary[@"publishedAt"]];
    
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
