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

@implementation ArticleCell

- (void)customizeCardView{
    
    // Customization for image view
    self.articleImageView.layer.cornerRadius = 20;
    self.articleImageView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    
    // Customization for rest of card view
    self.cardView.layer.cornerRadius = 20;
    self.cardView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
}



@end
