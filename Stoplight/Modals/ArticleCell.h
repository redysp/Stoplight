//
//  ArticleCell.h
//  Stoplight
//
//  Created by arleneigwe on 7/16/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticleCell : UICollectionViewCell
@property (strong, nonatomic) Article *article;
@property (strong, nonatomic) NSString *topic;

@end

NS_ASSUME_NONNULL_END