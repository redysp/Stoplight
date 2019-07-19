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

static NSString * const URLString = @"https://api.cognitive.microsoft.com/bing/v7.0/news?category=politics&mkt=en-us";
static NSString * const consumerKey = @"e909edf807a249468c765b6c379992ba";

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



-(void)getCategoryArticles:(NSString *)categoryString completion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    //general, business, sports, science, tech articles
    //NSString *urlWithCountry = [topHeadlinesURLString stringByAppendingString:countryString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc]initWithString:URLString]; //should be full URL
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url]; //Request object
    [request setValue:consumerKey forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    [self makeRequestWithCompletion:session request:request completionHandler:completion];
}

@end
