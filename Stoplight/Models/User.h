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

//list of only source names and topics user prefers
@property (strong, nonatomic) NSMutableArray *preferred_topics;
@property (strong, nonatomic) NSMutableArray *preferred_sources;

//array to represent bools for each avail source
@property (strong, nonatomic) NSMutableArray *checkedSources;
@property (strong, nonatomic) NSMutableArray *checkedTopics;
@end

NS_ASSUME_NONNULL_END
