//
//  AdjustSourcesViewController.h
//  Stoplight
//
//  Created by emily13hsiao on 7/22/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdjustSourcesViewController : UIViewController
@property (strong, nonatomic) NSMutableDictionary *tempUserChoices;
@property (assign) NSInteger expandedSectionNumber;
@property (assign) UITableViewHeaderFooterView *expandedSectionHeader;
@property (strong) NSArray *sectionItems;
@property (strong) NSArray *sectionNames;
@end

NS_ASSUME_NONNULL_END
