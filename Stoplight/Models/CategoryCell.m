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
#import "User.h"

@implementation CategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.categoryCollectionView.delegate = self;
    self.categoryCollectionView.dataSource = self;
    [self.categoryCollectionView reloadData];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setOppositeAffiliation{
    
    // Not sure if this is the correct way
    
    NSString *currentAffiliation = [[User shared] getArticleAffiliation];

    if ([currentAffiliation  isEqual: @"left"]){
        self.oppositeAffiliation = @"right";
    }
    else if ([currentAffiliation isEqual:@"right"]){
        self.oppositeAffiliation = @"left";
    }
    else{
        // Here, randomization would occur and vary between left and right
        self.oppositeAffiliation = @"center";
    }
}

#pragma mark - Collection View Methods

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    ArticleCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"ArticleCell" forIndexPath:indexPath];
    @try {
        [cell customizeCardView];

        Article *article = self.articles[indexPath.row];
    
        cell.article = article;
        cell.vc = self.vc;
        
        [cell getLabelColor];

        
        //sets headline text
        if (article.title){
            cell.titleLabel.text = article.title;
        }
        
        //sets the image for the article's image view
        if (article.imageLink) {
            [cell.articleImageView setImageWithURL:article.imageLink];
        }
        
        // set the source for the card view
        cell.sourceLabel.text = article.provider; 
        
        //Returns an ArticleCell
        return cell;
    } @catch (NSException *exception) {
        
        return cell;
    }
}


//collection view asks its dataSource for num items in each section
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.articles.count;
}


@end
