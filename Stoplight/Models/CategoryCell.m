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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//table view asks its dataSource for num rows and cell for row at
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.articles.count;
}

//table view asks its dataSource for num rows and cell for row at
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    // custom table view cell defined and reuse identifier set
    ArticleCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"ArticleCell" forIndexPath:indexPath];
    
    //individual article object instantiated and initialized
    Article *article = self.articles[indexPath.item];
    
    //elements of cell
    cell.article = article;
    
    //sets the image for the article's image view
    if (article.imageLink) {
        [cell.articleImageView setImageWithURL: article.imageLink];
    }
    
    
    //return instance of custom cell and its reuse identifier w/ elements at proper index
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}


@end
