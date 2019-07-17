//
//  APIManager.m
//  Stoplight
//
//  Created by emily13hsiao on 7/16/19.
//  Copyright © 2019 powercarlos25. All rights reserved.

// Get business, sports, science, tech articles
//

#import "APIManager.h"
#import "Article.h"

static NSString * const everythingURLString = @"https://newsapi.org/v2/everything?";
static NSString * const topHeadlinesURLString = @"https://newsapi.org/v2/top-headlines?";
static NSString * const countryString = @"country=us&";
static NSString * const generalString = @"category=general&";
static NSString * const businessString = @"category=business&";
static NSString * const technologyString = @"category=technology&";
static NSString * const scienceString = @"category=science&";
static NSString * const consumerKey = @"apiKey=d4a4332cc1e943f98e4ca190cb8db7b0";

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

/**
 Returns the json data in dictionary form after a request.
 Dictionary has NOT been processed in any way, it's just the full result of the request.
 **/
-(NSDictionary *) makeRequest:(NSURLSession *)session request:(NSMutableURLRequest *)request {
    __block NSDictionary *result;
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        result = json;
    }];
    [task resume];
    return result;
}

/**
 Returns a dictionary of arrays.
 Key: category name
 Value: array of Articles
 **/
-(NSDictionary *)getAllArticles {
    //general, business, sports, science, tech articles
    NSString *urlWithCountry = [topHeadlinesURLString stringByAppendingString:countryString];
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
    NSURLSession *session = [NSURLSession sharedSession];
    
    //General category
    NSString *urlWithCategory = [urlWithCountry stringByAppendingString:generalString];
    NSString *requestString = [urlWithCategory stringByAppendingString:consumerKey];
    NSURL *url = [[NSURL alloc]initWithString:requestString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSArray *generalArticles = [self makeRequest:session request:request][@"articles"]; //array of dictionaries, not Articles
    generalArticles = [Article articlesWithArray:generalArticles];
    [results setObject:generalArticles forKey:@"general"];
    
    for (Article *article in generalArticles) {
        NSLog(@"%@", article.title);
    }
    
    //Business category
    urlWithCategory = [urlWithCountry stringByAppendingString:businessString];
    requestString = [urlWithCategory stringByAppendingString:consumerKey];
    url = [[NSURL alloc] initWithString:requestString];
    request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    return results;
}

@end
