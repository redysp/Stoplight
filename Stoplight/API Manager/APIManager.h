//
//  APIManager.h
//  Stoplight
//
//  Created by emily13hsiao on 7/16/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

+ (instancetype)shared;

-(void)getAllArticles:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion;
-(void)getCategoryArticles:(NSString *)categoryString completion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion;
@end

NS_ASSUME_NONNULL_END
