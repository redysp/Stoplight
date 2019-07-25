//
//  Article.h
//  Stoplight
//
//  Created by emily13hsiao on 7/16/19.

//  Created by arleneigwe on 7/16/19.

//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Article : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *link;
@property (nonatomic, strong) NSURL *imageLink;
@property (nonatomic, strong) NSString *provider;
@property (nonatomic, strong) NSString *affiliation;
@property (nonatomic, strong) NSString *category;
//@property (nonatomic, strong) NSString *author;
//@property (nonatomic, strong) NSString *description;
//@property (nonatomic, strong) NSString *text;
//@property (nonatomic, strong) NSDate *publishedAt;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)articlesWithArray:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
