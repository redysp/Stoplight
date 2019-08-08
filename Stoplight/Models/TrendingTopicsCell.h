//
//  TrendingTopicsCell.h
//  Stoplight
//
//  Created by emily13hsiao on 8/8/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrendingTopicsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *trendingImage;
@property (strong, nonatomic) IBOutlet UILabel *trendingTopicLabel;

@end

NS_ASSUME_NONNULL_END
