//
//  CategoryCell.h
//  Stoplight
//
//  Created by arleneigwe on 7/18/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) NSArray *articlesArray;

@end

NS_ASSUME_NONNULL_END
