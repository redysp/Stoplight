//
//  SearchArticleCell.m
//  Stoplight
//
//  Created by emily13hsiao on 8/1/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "SearchArticleCell.h"

@implementation SearchArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.affiliationView.layer.cornerRadius = 10;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
