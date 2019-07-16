//
//  APIManager.m
//  Stoplight
//
//  Created by emily13hsiao on 7/16/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "APIManager.h"

//static NSString * const baseURLString = @"https://newsapi.org/v2/everything?";
static NSString * const baseURLString = @"https://newsapi.org/v2/top-headlines?country=us&";
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



-(void)getAllArticles {
    NSString *requestString = [baseURLString stringByAppendingString: consumerKey];
    NSURL *url = [[NSURL alloc]initWithString:requestString];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    //[request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
        NSLog(@"Data: %@", json);
    }];

    [task resume];
    
    

}

@end
