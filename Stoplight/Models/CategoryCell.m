//
//  CategoryCell.m
//  Stoplight
//
//  Created by arleneigwe on 7/18/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

/**
 Public properties:
 @property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;
 @property (strong, nonatomic) IBOutlet UILabel *categoryNameLabel;
 @property (weak, nonatomic) NSArray *articlesArray;
 **/

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
