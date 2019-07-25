//
//  SourceCell.m
//  Stoplight
//
//  Created by arleneigwe on 7/24/19.
//  Copyright © 2019 powercarlos25. All rights reserved.
//

#import "SourceCell.h"
#import "User.h"
#import "AdjustSourcesViewController.h"

@implementation SourceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)isTapped:(id)sender {
    NSLog(@"I tapped that!");
    if (self.isSelected) {
        
        //if already checked, set to unchecked and remove source
        self.user.checkedSources[self.position] = @(NO);
        
        //changes cell accessory to None
        self.accessoryType = UITableViewCellAccessoryNone;
        
        //adds source to user sources list
        [self.sourceViewCon.tempUserChoices removeObject:self.source_name];
    } else {
        //if not already checked, set to checked and add source
        self.user.checkedSources[self.position] = @(YES);
        
        //changes cell acessory to checkmark
        self.accessoryType = UITableViewCellAccessoryCheckmark;
        
        //removes source from user sources list
        [self.sourceViewCon.tempUserChoices addObject:self.source_name];
    }
    //updates isSelected to reflect changes made
    self.isSelected = self.user.checkedSources[self.position];
}
@end
