//
//  SearchPageCell.h
//  Stoplight
//
//  Created by emily13hsiao on 7/31/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchPageCell : UICollectionViewCell

@property (strong, nonatomic) Article *article;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
