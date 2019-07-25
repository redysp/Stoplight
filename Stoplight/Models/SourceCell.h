//
//  SourceCell.h
//  Stoplight
//
//  Created by arleneigwe on 7/24/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "AdjustSourcesViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SourceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sourceCellLabel;
@property (assign, nonatomic) BOOL isSelected;
@property (nonatomic) NSInteger position;
@property (strong, nonatomic) NSString *source_name;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) AdjustSourcesViewController *sourceViewCon;

- (IBAction)isTapped:(id)sender;
@end

NS_ASSUME_NONNULL_END
