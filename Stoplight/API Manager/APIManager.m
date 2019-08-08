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
#import "Utility.h"

static NSString * const URLString = @"https://api.cognitive.microsoft.com/bing/v7.0/news/search?q=";
static NSString * const trendingURL = @"https://api.cognitive.microsoft.com/bing/v7.0/news/trendingtopics?mkt=en-us";
static NSString * const joinString = @"&";
static NSString * const siteString = @"+site:";
static NSString * const country = @"mkt=en-us";
static NSString * const consumerKey = @"0de3cc86e7664ea4914f0c0e9880a773";
static NSString * const imageBool = @"originalImg=true";
static NSString * const countString = @"count=";
static NSString * const offsetString = @"offset=";

static NSString * const testURL = @"https://api.cognitive.microsoft.com/bing/v7.0/news/search?q=+site:npr.org&originalImg=true&mkt=en-us";

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
 Returns the JSON data in dictionary form after a request.
 Dictionary has NOT been processed in any way, it's just the full result of the request.
 (Processing happens in completion block.)
 **/

-(void)makeRequestWithCompletion:(NSURLSession *)session
           request:(NSMutableURLRequest *)request
 completionHandler:(void(^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completion {
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!completion) {
            return;
        }
        completion(data, response, error);
    }];
    [task resume];
}

/**
 Input: what category to query for, and a completion block.
 Objective: Create GET request and send it to session to implement.
 The function that does the session calls the completion block.
 Output: void.
 **/
-(void)getCategoryArticles:(NSString *)source completion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {

    NSURLSession *session = [NSURLSession sharedSession];
    
    // Concatenate URL
    NSString *restOfURL = [NSString stringWithFormat:@"%@%@%@%@%@%@", siteString, source, joinString, country, joinString, imageBool];
    NSString *completeURL = [URLString stringByAppendingString:restOfURL];
    
    // Convert string to URL
    NSURL *url = [[NSURL alloc]initWithString:completeURL]; //should be full URL
    
    // Finish request, add API key
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url]; //Request object
    [request setValue:consumerKey forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    [self makeRequestWithCompletion:session request:request completionHandler:completion];
}


-(void)getTopicArticles:(NSString *)topic source:(NSString *)source completion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *restOfURL = [NSString stringWithFormat:@"%@%@%@%@%@", topic, siteString, source, joinString, country];
    NSString *completeURL = [URLString stringByAppendingString:restOfURL];
    NSURL *url = [[NSURL alloc]initWithString:completeURL]; //should be full URL
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url]; //Request object
    [request setValue:consumerKey forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    [self makeRequestWithCompletion:session request:request completionHandler:completion];
}

-(void)getTopicArticlesWithCountAndOffset:(NSString *)topic source:(NSString *)source count:(NSInteger)count offset:(NSInteger)offset completion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *restOfURL = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@", topic, siteString, source, joinString, country, joinString, countString, [NSString stringWithFormat:@"%ld", (long)count], joinString, offsetString, [NSString stringWithFormat:@"%ld", (long)offset]];
    NSString *completeURL = [URLString stringByAppendingString:restOfURL];

    NSURL *url = [[NSURL alloc]initWithString:completeURL]; //should be full URL
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url]; //Request object
    [request setValue:consumerKey forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    
    [self makeRequestWithCompletion:session request:request completionHandler:completion];
}

-(void)getTrendingTopicsWithCompletion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc] initWithString:trendingURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url]; //Request object
    [request setValue:consumerKey forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    [self makeRequestWithCompletion:session request:request completionHandler:completion];
}

//-(void)getSearchArticles:(NSString *)search completion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
//
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    NSString *queryString = [Utility topicToQuery:search];
//
//    NSString *restOfURL = [NSString stringWithFormat:@"%@%@%@", queryString, joinString, country];
//    NSString *completeURL = [URLString stringByAppendingString:restOfURL];
//
//    NSURL *url = [[NSURL alloc]initWithString:completeURL]; //should be full URL
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url]; //Request object
//    [request setValue:consumerKey forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
//    [self makeRequestWithCompletion:session request:request completionHandler:completion];
//
//}

@end
