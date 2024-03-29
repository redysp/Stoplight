//
//  AdjustCategoriesViewController.h
//  Stoplight
//
//  Created by emily13hsiao on 7/22/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTopicViewController.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AdjustTopicsViewControllerDelegate
- (void) didUpdateSources;
@end

@interface AdjustCategoriesViewController : UIViewController

@property (nonatomic, weak) id delegate;

@end

NS_ASSUME_NONNULL_END
