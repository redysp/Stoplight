//
//  SourceCell.h
//  Stoplight
//
//  Created by arleneigwe on 7/24/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface SourceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sourceCellLabel;
@property (nonatomic) bool *checkStatus;
@property (strong, nonatomic) User *user;
- (IBAction)isTapped:(id)sender;
@end

NS_ASSUME_NONNULL_END
