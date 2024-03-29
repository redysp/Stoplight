//
//  ArticleCell.h
//  Stoplight
//
//  Created by arleneigwe on 7/16/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
#import "FeedViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticleCell : UICollectionViewCell
@property (strong, nonatomic) Article *article;
@property (strong, nonatomic) NSString *topic;
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;
@property (strong, nonatomic) UIImage *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UIView *affiliationView;


@property (weak, nonatomic) FeedViewController *vc;



- (void)customizeCardView;
- (void)getLabelColor;

@end

NS_ASSUME_NONNULL_END
