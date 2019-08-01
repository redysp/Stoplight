//
//  CategoryCell.h
//  Stoplight
//
//  Created by arleneigwe on 7/18/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface CategoryCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>
  
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (strong, nonatomic) NSArray *articles;
@property (strong, nonatomic) FeedViewController *vc;

@end

NS_ASSUME_NONNULL_END
