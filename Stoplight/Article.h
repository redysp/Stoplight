//
//  Article.h
//  Stoplight
//
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Article : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSURL *link;
@property (nonatomic, strong) NSURL *imageLink;
@property (nonatomic, strong) NSString *provider;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *publishedAt;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (NSMutableArray *)articlesWithArray:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
