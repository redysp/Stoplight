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
    
    //get ArticleCell
    ArticleCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"ArticleCell" forIndexPath:indexPath];
    

    @try {
        Article *article = self.articles[indexPath.row];
        cell.article = article;
        
        //sets the image for the article's image view
        if (article.imageLink) {
            [cell.articleImageView setImageWithURL: article.imageLink];
        }
        
        //sets headline text
        if (article.title){
            cell.titleLabel.text = article.title;
        }
        
        //Returns an ArticleCell
        return cell;
    } @catch (NSException *exception) {
        
        return cell;
    }
    
    //return instance of custom cell and its reuse identifier w/ elements at proper index
    return cell;
}

//collection view asks its dataSource for num items in each section
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}


@end
