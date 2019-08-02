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
    
    // Customization for rest of card view
    self.cardView.layer.cornerRadius = 20;
    self.cardView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    
}

- (void)getButtonColor{
    // Changes the color of the button depending on the affiliation
    if ([self.article.affiliation isEqualToString:@"left"]){
        [self.readButton setBackgroundColor:[UIColor blueColor]];
    }
    else if ([self.article.affiliation isEqualToString:@"center"]){
        [self.readButton setBackgroundColor:[UIColor purpleColor]];
    }
    else{
        [self.readButton setBackgroundColor:[UIColor redColor]];
    }
}

-(void) readButtonPressed:(UIButton *)sender {
    [self.vc performSegueWithIdentifier:@"toWeb" sender:self];
}



@end
