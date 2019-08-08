//
//  ArticleCell.m
//  Stoplight
//
//  Created by arleneigwe on 7/16/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "ArticleCell.h"
#import "FeedViewController.h"
#import "CategoryCell.h"
#import "Article.h"

@implementation ArticleCell

- (void)customizeCardView{
    
    // Customization for image view
    self.articleImageView.layer.cornerRadius = 20;
    self.articleImageView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    
    // Customization for color label
    self.affiliationView.layer.cornerRadius = 10;
    
    // Customization for rest of card view
    self.cardView.layer.cornerRadius = 20;
    self.cardView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    
    // Add shadow for card view
    CALayer *cardLayer = self.cardView.layer;
    cardLayer.shadowOffset = CGSizeMake(1, 1);
    cardLayer.shadowColor = [[UIColor blackColor] CGColor];
    cardLayer.shadowRadius = 6.0f;
    cardLayer.shadowOpacity = 0.30f;
    cardLayer.shadowPath = [[UIBezierPath bezierPathWithRect:cardLayer.bounds] CGPath];
    
    // Add shadow to circle view
    CALayer *affiliationLayer = self.affiliationView.layer;
    affiliationLayer.shadowOffset = CGSizeMake(1, 1);
    affiliationLayer.shadowColor = [[UIColor blackColor] CGColor];
    affiliationLayer.shadowRadius = 6.0f;
    affiliationLayer.shadowOpacity = 0.30f;
    affiliationLayer.shadowPath = [[UIBezierPath bezierPathWithRect:affiliationLayer.bounds] CGPath];
    
}

- (void)getLabelColor{
    // Changes the color of the button depending on the affiliation
    if ([self.article.affiliation isEqualToString:@"left"]){
        [self.affiliationView setBackgroundColor:[UIColor blueColor]];
    }
    else if ([self.article.affiliation isEqualToString:@"center"]){
        [self.affiliationView setBackgroundColor:[UIColor purpleColor]];
    }
    else{
        [self.affiliationView setBackgroundColor:[UIColor redColor]];
    }
}

@end
