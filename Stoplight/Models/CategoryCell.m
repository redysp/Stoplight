//
//  CategoryCell.m
//  Stoplight
//
//  Created by arleneigwe on 7/18/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "CategoryCell.h"
#import "ArticleCell.h"
#import "Article.h"
#import "UIImageView+AFNetworking.h"

@implementation CategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.categoryCollectionView.delegate = self;
    self.categoryCollectionView.dataSource = self;
    [self.categoryCollectionView reloadData];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Collection View Methods
//table view asks its dataSource for num rows and cell for row at

//This is creating an ARTICLE CELL
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    ArticleCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"ArticleCell" forIndexPath:indexPath];
    
    @try {
        [cell customizeCardView];

        Article *article = self.articles[indexPath.row];
        cell.article = article;
        
        //sets headline text
        if (article.title){
            cell.titleLabel.text = article.title;
        }
        
        //sets the image for the article's image view
        if (article.imageLink) {
            [cell.articleImageView setImageWithURL:article.imageLink];
        }
        
        //Returns an ArticleCell
        return cell;
    } @catch (NSException *exception) {
        
        return cell;
    }
}

//collection view asks its dataSource for num items in each section
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}


@end
