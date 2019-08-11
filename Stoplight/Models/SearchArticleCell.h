//
//  SearchArticleCell.h
//  Stoplight
//
//  Created by emily13hsiao on 8/1/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchArticleCell : UITableViewCell

@property (strong, nonatomic) Article *article;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *articleImageView;
@property (strong, nonatomic) IBOutlet UIView *affiliationView;
@property (strong, nonatomic) IBOutlet UILabel *providerLabel;

@end

NS_ASSUME_NONNULL_END
