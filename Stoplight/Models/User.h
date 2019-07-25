//
//  User.h
//  Stoplight
//
//  Created by arleneigwe on 7/16/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (strong,nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *politics;

//on set-up both should be set to NSUserDefaults
@property (strong, nonatomic) NSMutableArray *preferred_topics;
@property (strong, nonatomic) NSMutableArray *preferred_sources;
@property (strong, nonatomic) NSMutableArray *isCheckedS;
@property (strong, nonatomic) NSMutableArray *isCheckedT;
@end

NS_ASSUME_NONNULL_END
